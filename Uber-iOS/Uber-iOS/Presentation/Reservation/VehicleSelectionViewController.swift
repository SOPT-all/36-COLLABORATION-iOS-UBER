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
    
    // Contents
    
    private let uberTaxiStack = UIStackView().then {
        $0.axis = .vertical
        let label1 = UILabel()
        let label2 = UILabel()
        
        label1.text = "택시1"
        label2.text = "택시2"
        $0.addArrangedSubviews(label1, label2)
    }
    
    private lazy var reserveInfoViews: [ReserveInfoView] = {
        
        // Define initial model
        
        let configures: [ReserveInfoStyle] = [
            .active(icon: .icFlight32, title: "공항 갈 때", subtitle: "캐리어 걱정 없이 쾌적하게 이동", additionalViews: []),
            .inactive(icon: .icChildCare32, title: "아기와 함께 할 때", subtitle: "카시트로 안전하게, 걱정없는 이동"),
            .inactive(icon: .icDirectionsCar32, title: "장거리 운전을 해야할 때", subtitle: "렌터카 빌릴 필요 없이 편안하게"),
            .inactive(icon: .icGTranslate32, title: "외국인 손님과 함께", subtitle: "외국어 가능 기사님으로 문제없는 의사소통")
        ]
        
        // Add gesture & configure
        
        let reserveInfoViews: [ReserveInfoView] = configures.map { configure in
                .init().then {
                    $0.configure(configure)
                    $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reserveInfoTapped(_:))))
                }
        }
        
        return reserveInfoViews
    }()
    
    private lazy var suggestedVehicleStack = UIStackView().then {
        let stackView = $0
        stackView.axis = .vertical
        stackView.spacing = 20
        reserveInfoViews.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private let buttonContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let goToReservInfoButton = UIButton().then {
        $0.setTitle("차량 서비스 예약", for: .normal)
        $0.applyUberStyle()
    }
    
    // Sections containing contents
    
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
    
    // Container containing sections
    
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
        buttonContainer.addSubview(goToReservInfoButton)
        addSubviews(scrollView, buttonContainer)
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
        
        buttonContainer.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        goToReservInfoButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalTo(buttonContainer.safeAreaLayoutGuide).inset(6)
            $0.bottom.equalTo(buttonContainer.safeAreaLayoutGuide).inset(6)
            $0.height.equalTo(56)
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

// MARK: - UIAction

extension VehicleSelectionViewController {
    @objc private func reserveInfoTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view as? ReserveInfoView else { return }
        // TODO: 임의로 컬러를 바꾸는중 인터페이스 변경이 필요함
        reserveInfoViews.forEach { $0.layer.borderColor = UIColor.graysub.cgColor }
        tappedView.layer.borderColor = UIColor.btnActive.cgColor
    }
}
