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
    
    // Contents
    
    private let uberTaxiStack = UIStackView().then {
        $0.axis = .vertical
        let label1 = UILabel()
        let label2 = UILabel()
        
        label1.text = "택시1"
        label2.text = "택시2"
        $0.addArrangedSubviews(label1, label2)
    }
    
    private let suggestedVehicleStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        let suggestedAirplane = ReserveInfoView()
        let suggestedBaby = ReserveInfoView()
        let suggestedLongDrive = ReserveInfoView()
        let suggestedForeigner = ReserveInfoView()
        suggestedAirplane.configure(.active(icon: .icFlight32, title: "공항 갈 때", subtitle: "캐리어 걱정 없이 쾌적하게 이동", additionalViews: []))
        suggestedBaby.configure(.inactive(icon: .icChildCare32, title: "아기와 함께 할 때", subtitle: "카시트로 안전하게, 걱정없는 이동"))
        suggestedLongDrive.configure(.inactive(icon: .icDirectionsCar32, title: "장거리 운전을 해야할 때", subtitle: "렌터카 빌릴 필요 없이 편안하게"))
        suggestedForeigner.configure(.inactive(icon: .icGTranslate32, title: "외국인 손님과 함께", subtitle: "외국어 가능 기사님으로 문제없는 의사소통"))
        $0.addArrangedSubviews(suggestedAirplane, suggestedBaby, suggestedLongDrive, suggestedForeigner)
    }
    
    // ScrollView
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false        
    }
    
    // Sections
    
    private lazy var sections: [SectionView] = [
        .init(
            title: "우버 기본 택시 제안",
            subtitle: .init(string: "우버가 제공하는 기본 택시들을 이용해보세요.\n안전하고 편리한 여정을 보장합니다."),
            content: uberTaxiStack,
            contentEdge: .init(top: 10, left: 5.5, bottom: 0, right: 5.5)
        ),
        .init(
            title: "상황별 맞춤 차량 제안",
            subtitle: .init(string: "상황에 최적화 된 차량과 기사님을 만나보세요 \n가장 훌륭한 탑승 경험을 누릴 수 있어요"),
            content: suggestedVehicleStack,
            contentEdge: .init(top: 20, left: 10, bottom: 10, right: 10))
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
        view.backgroundColor = .white
    }
}

#Preview {
    VehicleSelectionViewController()
}
