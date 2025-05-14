//
//  ReservationInfoViewController.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

import SnapKit

// MARK: - Properties

final class ReservationInfoViewController: UIViewController {
    
    // Content
    
    private let pickupTimeLabel = UILabel().then {
        $0.font = .caption_m12
        $0.textColor = .sub1
        $0.attributedText = "05월 05일 (월) / 오전 20:16".replaceFont(pattern: "[0-9]|\\([ㄱ-ㅣ가-힣]\\)", replaceFont: .body2_sb16)
    }
    
    // Sections
    
    private let startAndArriveSection = SectionView(title: "출발/도착", content: UIView())
    
    private lazy var pickupTimeSection = SectionView(title: "픽업 시간", content: pickupTimeLabel, contentEdge: .init(top: 0, left: 25, bottom: 0, right: 25))
    
    private let expectedArriveSection = SectionView(title: "예정 도착 시간", content: UIView())
    
    private let taxiSelectionSection = SectionView(title: "차량 선택", subtitle: "상황에 최적화 된 차량과 기사님을 만나보세요\n가장 훌륭한 탑승 경험을 누릴 수 있어요", content: UIView())
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var contentStackView = UIStackView().then {
        $0.backgroundColor = .bgGray
        $0.axis = .vertical
        $0.spacing = 8
        
        $0.addArrangedSubviews(startAndArriveSection,
                               pickupTimeSection,
                               expectedArriveSection,
                               taxiSelectionSection)
    }
}

// MARK: - LifeCycle

extension ReservationInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setLayout()
    }
}

// MARK: - Layout

extension ReservationInfoViewController {
    private func addSubViews() {
        scrollView.addSubview(contentStackView)
        [scrollView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
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

#Preview {
    ReservationInfoViewController()
}

