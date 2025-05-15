//
//  VehicleSelectionButton.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/16/25.
//

import UIKit

import SnapKit

final class VehicleSelectionButton: UIButton {
      
    private let vehicleImage = UIImageView().then {
        $0.image = UIImage(resource: .taxi)
    }
    
    private let vehicleNameLabel = UILabel().then {
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 27)
        $0.font = .body1_eb18
        $0.textColor = .primary
        $0.numberOfLines = 0        
    }
    
    private let userImage = UIImageView(image: UIImage(resource: .guest))
    
    private let guestLabel = UILabel().then {
        $0.font = .caption_m12
        $0.textColor = .primary
        $0.numberOfLines = 0
    }
    
    private let priceLabel = UILabel().then {
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 24)
        $0.font = .body2_sb16
        $0.textColor = .sub2
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textAlignment = .right
        $0.font = .caption_m12
        $0.textColor = .sub3
    }
    
    private let containerView = UIView().then {
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        // Set default style
        
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderColor = UIColor.black.cgColor
        
        // Configure viewhierarcy
        
        addSubview(containerView)
        
        containerView.addSubviews(vehicleImage,
                                  vehicleNameLabel,
                                  userImage,
                                  guestLabel,
                                  priceLabel,
                                  descriptionLabel)
        
        // Set constraint
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vehicleImage.snp.makeConstraints {
            $0.size.equalTo(54)
            $0.verticalEdges.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().offset(4)
        }
        
        vehicleNameLabel.snp.makeConstraints {
            $0.leading.equalTo(vehicleImage.snp.trailing).offset(2)
            $0.top.equalTo(vehicleImage).offset(2.5)
        }
        
        userImage.snp.makeConstraints {
            $0.leading.equalTo(vehicleNameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(vehicleNameLabel)
        }
        
        guestLabel.snp.makeConstraints {
            $0.leading.equalTo(userImage.snp.trailing).offset(2)
            $0.centerY.equalTo(vehicleNameLabel)
            $0.trailing.greaterThanOrEqualTo(descriptionLabel.snp.leading).offset(-4)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(vehicleNameLabel)
            $0.top.equalTo(vehicleNameLabel.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalTo(vehicleNameLabel)
            $0.trailing.equalToSuperview().inset(7)
            $0.leading.equalTo(guestLabel.snp.trailing)
        }
        
    }
    
    // Change button style
    
    func setSelected() {
        layer.borderWidth = 2
    }
    
    func setUnselected() {
        layer.borderWidth = 0
    }
}

