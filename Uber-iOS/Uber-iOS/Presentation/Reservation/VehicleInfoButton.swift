//
//  VehicleInfoButton.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/22/25.
//

import UIKit

import SnapKit

final class VehicleInfoButton: UIButton {
    
    private let contentStack = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = .init(top: 0, left: 15, bottom: 0, right: 15)
        $0.alignment = .center
        $0.spacing = 5
        $0.distribution = .fillProportionally
        $0.isHidden = true
        $0.isUserInteractionEnabled = false
    }
    private let carImageView = UIImageView().then {
        $0.image = .taxi
        $0.contentMode = .scaleAspectFit
    }
    private let selectedCarInfo = UILabel().then {
        $0.text = "공항갈 때/ Uber SUV"
        $0.font = .body1_eb18
    }
    private let guestLabel = UILabel().then {
        $0.text = "6"
        $0.font = .caption_m12
    }
    private let guestImageView = UIImageView().then {
        $0.image = .guest
        $0.contentMode = .scaleAspectFit
    }
    private let moveButtonImageView = UIImageView().then {
        $0.image = .rightIcon
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var carInfoStack = UIStackView().then {
        $0.addArrangedSubviews(selectedCarInfo, guestImageView, guestLabel)
        $0.spacing = 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        setTitle("차량 선택하기 ", for: .normal) // 텍스트 제거
        setTitleColor(.primary, for: .normal)
        titleLabel?.font = .body2_sb16
        layer.borderWidth = 1
        layer.cornerRadius = 12
        layer.borderColor = UIColor.black.cgColor
        
        [carImageView, carInfoStack, moveButtonImageView].forEach {
            contentStack.addArrangedSubview($0)
        }
        
        carImageView.snp.makeConstraints {
            $0.size.equalTo(54)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(68)
        }
        
        moveButtonImageView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setVehicleInfo(_ taxiInfo: TaxiInfoEntity) {
        layer.borderWidth = 2.0
        contentStack.isHidden = false
        setTitle(nil, for: .normal)
        self.carImageView.load(url: URL(string: taxiInfo.image)!)
        self.selectedCarInfo.text = "공항갈때 / \(taxiInfo.type)"
        self.guestLabel.text = "\(taxiInfo.guests)"
    }
    
    func setDefaultStyle() {
        layer.borderWidth = 1.0
        contentStack.isHidden = true
        setTitle("차량 선택하기", for: .normal)
    }
}
