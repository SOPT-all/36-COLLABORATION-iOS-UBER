//
//  VehicleSelectionViewController.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/16/25.
//

import UIKit

import SnapKit

final class VehicleSelectionViewController: BaseViewController {
    
    // MARK: - Properties
    
    // ScrollView
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    // Sections
    
    private let sections: [SectionView] = [
        .init(
            title: "차량 선택",
            subtitle: .init(string: "상황에 최적화 된 차량과 기사님을 만나보세요\n가장 훌륭한 탑승 경험을 누릴 수 있어요"),
            content: UIView(),
            contentEdge: .init(top: 0, left: 5.5, bottom: 0, right: 5.5)
        ),
        .init(
            title: "상황별 맞춤 차량 제안",
            subtitle: .init(string: "상황에 최적화 된 차량과 기사님을 만나보세요 \n가장 훌륭한 탑승 경험을 누릴 수 있어요"),
            content: UIView(),
            contentEdge: .init())
    ]
    
    // Container containing contents
    
    private lazy var contentStackView = UIStackView().then {
        let stackView = $0
        stackView.backgroundColor = .bgGray
        stackView.axis = .vertical
        stackView.spacing = 8
        
        sections.forEach { section in
            stackView.addArrangedSubview(section)
        }
    }
    
    // MARK: - Layout
    
    override func configure() {
        scrollView.addSubview(contentStackView)
        addSubviews(scrollView)
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
}

// MARK: - LifeCycle

extension VehicleSelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#Preview {
    VehicleSelectionViewController()
}
