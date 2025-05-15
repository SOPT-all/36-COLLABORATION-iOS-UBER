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
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(resource: .route)
    }
    
    private let pickupTimeLabel = UILabel().then {
        $0.font = .caption_m12
        $0.textColor = .sub1
        $0.attributedText = "05월 05일 (월) / 오전 20:16".replaceFont(pattern: "[0-9]|\\([ㄱ-ㅣ가-힣]\\)", replaceFont: .body2_sb16)
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 24)
    }
    
    private let expectedArriveLabel = UILabel().then {
        $0.font = .caption_m12
        $0.textColor = .sub1
        $0.attributedText = "오전 20:31".replaceFont(pattern: "[0-9]|\\([ㄱ-ㅣ가-힣]\\)", replaceFont: .body2_sb16)
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 24)
    }
    
    private let expectedArriveDetailLabel = UILabel().then {
        $0.font = .caption_m12
        $0.textColor = .sub1
        $0.text = "예상 운행 시간 약 25분 소요 예상"
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 18)
    }
    
    private lazy var expectedArriveStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.addArrangedSubviews(expectedArriveLabel, expectedArriveDetailLabel)
    }
    
    private lazy var vehicleSelectionButton = UIButton().then {
        $0.setTitle("차량 선택하기", for: .normal)
        $0.setTitleColor(.primary, for: .normal)
        $0.titleLabel?.font = .body2_sb16
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.black.cgColor
        $0.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        $0.addTarget(self, action: #selector(vehicleSelectionButtonTapped), for: .touchUpInside)
    }
    
    private let expectedPaymentLabel = UILabel().then {
        $0.font = .caption_m12
        $0.textColor = .sub1
        $0.attributedText = "₩ 15,000 - 19,000".replaceFont(pattern: "[0-9]", replaceFont: .body2_sb16)
    }
    
    private lazy var directPaymentView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 4
        
        let cardImageView = UIImageView(image: UIImage(resource: .card)).then {
            $0.contentMode = .scaleAspectFit
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.snp.makeConstraints { $0.width.equalTo(36) }
        }
        
        let paymentLabel = UILabel().then {
            $0.text = "직접 결제"
            $0.font = .body2_eb16
            $0.textColor = .primary
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }
        
        let rightIconImageView = UIImageView(image: UIImage(resource: .rightIcon)).then {
            $0.contentMode = .scaleAspectFit
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.snp.makeConstraints { $0.width.height.equalTo(24) }
        }
        
        $0.addArrangedSubviews(cardImageView, paymentLabel, rightIconImageView)
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(directPaymentButtonTapped))
        $0.addGestureRecognizer(tapGesture)
    }
    
    // ScrollView
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    // Sections containing content
    
    private lazy var startAndArriveSection = SectionView(
        title: "출발/도착",
        content: imageView,
        contentEdge: .init(top: 10, left: 15, bottom: 10, right: 15)
    )
    
    private lazy var pickupTimeSection = SectionView(
        title: "픽업 시간",
        content: pickupTimeLabel,
        contentEdge: .init(top: 0, left: 25, bottom: 0, right: 25)
    )
    
    private lazy var expectedArriveSection = SectionView(
        title: "예정 도착 시간",
        content: expectedArriveStack,
        contentEdge: .init(top: 0, left: 25, bottom: 10, right: 25)
    )
    
    private lazy var vehicleSelectionSection = SectionView(
        title: "차량 선택",
        subtitle: .init(string: "상황에 최적화 된 차량과 기사님을 만나보세요\n가장 훌륭한 탑승 경험을 누릴 수 있어요"),
        content: vehicleSelectionButton,
        contentEdge: .init(top: 16, left: 17.5, bottom: 6, right: 17.5)
    )
    
    private lazy var expectedPaymentAccountSection = SectionView(
        title: "예상 결제 금액",
        subtitle: .init(string: "적용 가능한 할인 혜택이 없습니다.")
            .prependImage(image: UIImage(resource: .promotion), imageSize: .init(width: 18, height: 18)),
        content: expectedPaymentLabel,
        contentEdge: .init(top: 0, left: 25, bottom: 10, right: 25)
    )
    
    private lazy var directPaymentSection = SectionView(
        title: "",
        content: directPaymentView,
        contentEdge: .init(top: 10, left: 18, bottom: 10, right: 18)
    )
    
    
    // Container containing sections
    
    private lazy var contentStackView = UIStackView().then {
        $0.backgroundColor = .bgGray
        $0.axis = .vertical
        $0.spacing = 8
        expectedPaymentAccountSection.headerAxis = .horizontal
        $0.addArrangedSubviews(startAndArriveSection,
                               pickupTimeSection,
                               expectedArriveSection,
                               vehicleSelectionSection,
                               expectedPaymentAccountSection,
                               directPaymentSection)
        
        $0.setCustomSpacing(0, after: pickupTimeSection)
    }
}

// MARK: - LifeCycle

extension ReservationInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setLayout()
    }
}

// MARK: - Layout

extension ReservationInfoViewController {
    private func addSubViews() {
        scrollView.addSubview(contentStackView)
        view.addSubview(scrollView)
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

// MARK: - UI Action

extension ReservationInfoViewController {
    @objc private func vehicleSelectionButtonTapped() {
        
    }
    
    @objc private func directPaymentButtonTapped() {
       
    }
}

#Preview {
    ReservationInfoViewController()
}

