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
    private let locationService = LocationService()
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
        departureField.textField.delegate = self
        arrivalField.textField.delegate = self
        
        departureField.textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEndOnExit)
        arrivalField.textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEndOnExit)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    private func moveToPickerTimeView() {
        let pickerVC = PickupTimeViewController()
        self.navigationController?.pushViewController(pickerVC, animated: true)
    }
}


// MARK: - UI Action
extension RecentSearchViewController {
    @objc private func didTapDeleteAll() {
        Task { await deleteAllKeywords() }
    }
    
    @MainActor
    private func deleteAllKeywords() async {
        await searchService.deleteAllSearchKeywords()
        items = []
    }
    
    @objc private func textFieldDidEndEditing() {
        guard
            let departure = departureField.textField.text, !departure.isEmpty,
            let arrival = arrivalField.textField.text, !arrival.isEmpty,
            departure != arrival
        else {
            showAlert(message: "출발지와 도착지를 올바르게 입력해주세요.")
            return
        }
        
        Task {
            do {
                try await locationService.sendLocation(departures: departure, destination: arrival)
                print("🥳 출발지/도착지 전송 성공")
                self.moveToPickerTimeView()
            } catch {
                print("😱 에러 발생: \(error.localizedDescription)")
                showAlert(message: "요청 중 오류가 발생했습니다.\n다시 시도해주세요.")
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension RecentSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldDidEndEditing()
        return true
    }
}

extension RecentSearchViewController: UberNavigationConfigurable {
    var uberTitle: String? { "차량 서비스 예약" }
}
