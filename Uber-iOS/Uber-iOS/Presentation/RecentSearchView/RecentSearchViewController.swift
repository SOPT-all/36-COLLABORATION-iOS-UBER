//
//  RecentSearchViewController.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/22/25.
//

import SnapKit
import Then
import UIKit

final class RecentSearchViewController: BaseViewController {
    
    private let searchService: SearchService = SearchService()
    
    private let departureField = SearchLocationTextField(
        icon: UIImage(named: "departure"),
        placeholder: "출발지 검색"
    )
    
    private let arrivalField = SearchLocationTextField(
        icon: UIImage(named: "place"),
        placeholder: "도착지 검색"
    )
    
    private lazy var textFieldStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.addArrangedSubviews(departureField, arrivalField)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    private let headerView = RecentSearchHeaderView()
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.alwaysBounceVertical = true
    }
    
    private let contentView = UIView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    private var items: [SearchKeywordEntity] = [] {
        didSet { updateContent() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecentSearch()
    }
    
    override func configure() {
        super.configure()
        view.addSubviews(textFieldStack, headerView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        headerView.allDeleteButton.addTarget(
            self,
            action: #selector(didTapDeleteAll),
            for: .touchUpInside
        )
    }
    
    override func setConstraints() {
        super.setConstraints()
        textFieldStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        headerView.snp.makeConstraints {
            $0.top.equalTo(textFieldStack.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    // MARK: - Data & Content
    private func fetchRecentSearch() {
        Task {
            do {
                let list = try await SearchService().fetchSearchKeywords()
                items = list
            } catch {
                print("Error fetching recent searches: \(error)")
            }
        }
    }
    
    @MainActor
    private func deleteKeyword(id: Int) async {
        do {
            try await searchService.deleteSearchKeyword(id: id)
            items.removeAll { $0.id == id }
            updateContent()
        } catch {
            print("삭제 실패 \(error.localizedDescription)")
        }
    }
    
    private func updateContent() {
        stackView.arrangedSubviews.forEach {
            if $0 is RecentSearchCell {
                stackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
        }
        items.forEach { entity in
            let cellView = RecentSearchCell()
            cellView.configure(
                id: Int(entity.id),
                title: "\(entity.id). \(entity.location)",
                location: entity.address,
                date: entity.date,
                deleteAction: { [weak self] id in
                    Task { await self?.deleteKeyword(id: id) }
                }
            )
            stackView.addArrangedSubview(cellView)
        }
    }
}

extension RecentSearchViewController {
    @objc private func didTapDeleteAll() {
        Task { await deleteAllKeywords() }
    }
    
    @MainActor
    private func deleteAllKeywords() async {
        await searchService.deleteAllSearchKeywords()
        items = []
    }
}

extension RecentSearchViewController: UberNavigationConfigurable {
    var uberTitle: String? { "차량 서비스 예약" }
}
