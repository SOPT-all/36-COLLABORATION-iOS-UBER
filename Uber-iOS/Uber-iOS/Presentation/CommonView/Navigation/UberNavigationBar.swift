//
//  UberNavigationBar.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/16/25.
//

import UIKit

import SnapKit

protocol UberNavigationConfigurable {
    // Set navigation title
    var uberTitle: String? { get }
    // Set title size
    var prefersLargeTitle: Bool { get }
    var alignTitleLeft: Bool { get }
    var backButtonHidden: Bool { get }
}

extension UberNavigationConfigurable {
    var prefersLargeTitle: Bool { false }
    var alignTitleLeft: Bool { false }
    var backButtonHidden: Bool { false }
}

final class UberNavigationBar: UIView {
    
    // BackButton
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(resource: .backButton), for: .normal)
    }
    
    // TitleLabel
    
    let titleLabel = UILabel().then {
        $0.font = .body1_b18
        $0.textColor = .primary
    }
    
    // RightItem
    
    let rightItem = UIButton()
    
    
    private var leadingConstraint: Constraint?
    private var leadingButtonConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubviews(backButton, titleLabel, rightItem)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            self.leadingButtonConstraint = $0.leading.equalTo(backButton.snp.trailing).offset(10).constraint
            self.leadingConstraint = $0.leading.equalToSuperview().offset(18).constraint
        }
        
        rightItem.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
        }
        
        leadingButtonConstraint?.deactivate()
        leadingConstraint?.deactivate()
    }
    
    func applyConfiguration(_ configurable: UberNavigationConfigurable) {
        titleLabel.text = configurable.uberTitle
        titleLabel.font = configurable.prefersLargeTitle ? .title1_eb32 : .body1_b18
        backButton.isHidden = configurable.backButtonHidden ? true : false
        
        if configurable.alignTitleLeft, configurable.backButtonHidden {
            leadingButtonConstraint?.deactivate()
            leadingConstraint?.activate()
        } else if configurable.alignTitleLeft, !configurable.backButtonHidden {
            leadingButtonConstraint?.activate()
            leadingConstraint?.deactivate()
        }
    }
}
