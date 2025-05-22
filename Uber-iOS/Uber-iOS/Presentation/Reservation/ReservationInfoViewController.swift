//
//  ReservationInfoViewController.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

import SnapKit

final class ReservationInfoViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let pickupDateTime: Date
    
    private var discountInfo: DiscountModel?
    
    // MARK: - Intilizer
    
    init(pickupDateTime: Date) {
        self.pickupDateTime = pickupDateTime
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCouponInfo()
        bind()
    }
    
    // MARK: - UI Component
    
    private lazy var couponStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.addArrangedSubviews(expectedPaymentLabel)
    }
    
    private let startLocationTextField = SearchLocationTextField(icon: .place, placeholder: "").then {
        $0.textField.text = "서울시 마포구 동교로 19길 86"
        $0.backgroundColor = .white
        $0.applyFilledStyle()
    }
    private let arriveLocationTextField = SearchLocationTextField(icon: .place, placeholder: "").then {
        $0.textField.text = "김포공항"
        $0.backgroundColor = .white
        $0.applyFilledStyle()
    }
    
    private lazy var locationStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.addArrangedSubviews(startLocationTextField, arriveLocationTextField)
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var startAndArriveStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.addArrangedSubviews(locationStack, imageView)
    }
    
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
    
    private lazy var vehicleInfoButton = VehicleInfoButton().then {
        $0.addTarget(self, action: #selector(vehicleInfoButtonTapped), for: .touchUpInside)
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
    
    private let buttonContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var goTovehicleReservButton = UIButton().then {
        $0.setTitle("차량 서비스 예약", for: .normal)
        $0.applyUberStyle()
        $0.addTarget(self, action: #selector(goTovehicleReservButtonTapped), for: .touchUpInside)
    }
    
    // ScrollView
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = .init(top: 0, left: 0, bottom: 92, right: 0)
    }
    
    // Sections containing content
    
    private lazy var sections: [SectionView] = [
        .init(
            title: "출발/도착",
            content: startAndArriveStack,
            contentEdge: .init(top: 10, left: 15, bottom: 10, right: 15)
        ),
        .init(
            title: "픽업 시간",
            content: pickupTimeLabel,
            contentEdge: .init(top: 0, left: 25, bottom: 0, right: 25)
        ),
        .init(
            title: "예정 도착 시간",
            content: expectedArriveStack,
            contentEdge: .init(top: 0, left: 25, bottom: 10, right: 25)
        ),
        .init(
            title: "차량 선택",
            subtitle: .init(string: "상황에 최적화 된 차량과 기사님을 만나보세요\n가장 훌륭한 탑승 경험을 누릴 수 있어요"),
            content: vehicleInfoButton,
            contentEdge: .init(top: 16, left: 17.5, bottom: 6, right: 17.5)
        ),
        .init(
            title: "예상 결제 금액",
            subtitle: .init(string: "적용 가능한 할인 혜택이 없습니다.")
                .prependImage(image: UIImage(resource: .promotion), imageSize: .init(width: 18, height: 18)),
            content: couponStack,
            contentEdge: .init(top: 10, left: 17.5, bottom: 10, right: 17.5)
        ).then { $0.headerAxis = .horizontal },
        .init(
            title: "",
            content: directPaymentView,
            contentEdge: .init(top: 10, left: 18, bottom: 10, right: 18)
        )
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
        stackView.setCustomSpacing(0, after: sections[1])
    }
    
    // Override method
    
    override func configure() {
        scrollView.addSubview(contentStackView)
        buttonContainer.addSubview(goTovehicleReservButton)
        [scrollView, buttonContainer].forEach {
            view.addSubview($0)
        }
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
        
        goTovehicleReservButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalTo(buttonContainer.safeAreaLayoutGuide).inset(6)
            $0.bottom.equalTo(buttonContainer.safeAreaLayoutGuide).inset(6)
            $0.height.equalTo(56)
        }
    }
    
    private func loadCouponInfo() {
        DiscountModel.makeDummy().forEach {
            let discountCard = DiscountCard()
            discountCard.configure($0)
            couponStack.addArrangedSubview(discountCard)
            self.discountInfo = $0
        }
    }
    
    private func bind() {
        let pickupTimeString = pickupDateTime.formmatedString("MM월 dd일 (E) / a:hh:mm")
        let expectedArriveTime = pickupDateTime.addingTimeInterval(TimeInterval(integerLiteral: 60 * 25))
        let expectedArriveTimeString = expectedArriveTime.formmatedString("a hh:mm")
        pickupTimeLabel.attributedText = pickupTimeString.replaceFont(pattern: "[0-9]|\\([ㄱ-ㅣ가-힣]\\)", replaceFont: .body2_sb16)
        expectedArriveLabel.attributedText =  expectedArriveTimeString.replaceFont(pattern: "[0-9]|\\([ㄱ-ㅣ가-힣]\\)", replaceFont: .body2_sb16)
    }
}

// MARK: - UI Action

extension ReservationInfoViewController {
    @objc private func vehicleInfoButtonTapped() {
        let vehicleSelectionVC = VehicleSelectionViewController(service: VehicleService())
        vehicleSelectionVC.delegate = self
        navigationController?.pushViewController(vehicleSelectionVC, animated: true)
    }
    
    @objc private func directPaymentButtonTapped() {
        
    }
    
    @objc private func goTovehicleReservButtonTapped() {
        let completeVC = ReservationCompleteViewController()
        navigationController?.pushViewController(completeVC, animated: true)
    }
}

// MARK: - UberNavigationConfigurable

extension ReservationInfoViewController: UberNavigationConfigurable {
    var uberTitle: String? {
        "예약 정보"
    }
}

extension ReservationInfoViewController: VehicleSelectionViewControllerDelegate {
    func selectedTaxi(taxiInfo: TaxiInfoEntity) {
        vehicleInfoButton.setVehicleInfo(taxiInfo)
    }
}

#Preview {
    ReservationInfoViewController(pickupDateTime: .now)
}
