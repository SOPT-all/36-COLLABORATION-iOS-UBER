//
//  DiscountCard.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/21/25.
//

import UIKit

import SnapKit

struct DiscountModel {
    let discountPrice: Int
    let discountType: String
    let discountDescription: String
    
    init(discountPrice: Int, discountType: String, discountDescription: String) {
        self.discountPrice = discountPrice
        self.discountType = discountType
        self.discountDescription = discountDescription
    }
    
    init() {
        self.discountPrice = 0
        self.discountType = ""
        self.discountDescription = ""
    }
    
    static func makeDummy() -> [DiscountModel] {
        [
            .init(discountPrice: 5000, discountType: "첫 결제 할인 혜택 쿠폰", discountDescription: "운행 금액과 무관하게 적용 가능\n*Uber Black Taxi에는 사용 불가")            
        ]
    }
}

final class DiscountCard: UIView {
    
    var discountInfo = DiscountModel() {
        didSet {
            bind()
        }
    }
    
    private let discountPriceLabel = UILabel().then {
        $0.font = .body1_eb18
        $0.textColor = .primary
        $0.setTextWithLineHeight(text: "5000원", lineHeight: 27)
    }
    
    private let couponCategoryLabel = UILabel().then {
        $0.setTextWithLineHeight(text: "첫 결제 할인 혜택 쿠폰원", lineHeight: 18)
        $0.font = .caption_m12
        $0.textColor = .sub2
    }
    
    private let discountDescriptionLabel = UILabel().then {
        $0.text = "운행 금액과 무관하게 적용 가능\n*Uber Black Taxi에는 사용 불가"
        $0.font = .caption_m12
        $0.textColor = .sub3
        $0.numberOfLines = 2
    }
    
    private lazy var discountInfoStack = UIStackView().then {
        $0.axis = .vertical
        $0.addArrangedSubviews(discountPriceLabel, couponCategoryLabel, discountDescriptionLabel)
    }
    
    private let containerView = UIView()
    
    let deleteButton = UIButton().then {
        $0.setImage(.deleteBlack, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 15
        containerView.addSubviews(discountInfoStack, deleteButton)
        addSubviews(containerView)
        
        discountInfoStack.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(deleteButton.snp.leading)
            $0.verticalEdges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(11)
        }
    }
    
    private func bind() {
        self.discountPriceLabel.attributedText = NSMutableAttributedString(string: "\(discountInfo.discountPrice)원").prependImage(image: .promotion, imageSize: .init(width: 18, height: 18))
        self.couponCategoryLabel.text = discountInfo.discountType
        self.discountDescriptionLabel.text = discountInfo.discountDescription
    }
    
    func configure(_ discountInfo: DiscountModel) {
        self.discountInfo = discountInfo
    }
    
    @objc private func deleteButtonTapped() {
        self.removeFromSuperview()
    }
}
