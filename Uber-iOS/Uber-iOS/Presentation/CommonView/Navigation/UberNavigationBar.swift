//
//  UberNavigationBar.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/16/25.
//

import UIKit

import SnapKit

final class UberNavigationBar: UIView {
    
    // Container containing items
    
    let menuStackView = UIStackView().then {
        $0.distribution = .equalCentering
        $0.alignment = .center
    }
    
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
    
    private var centerConstraint: Constraint?
    private var leadingConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubviews(menuStackView)
        menuStackView.addArrangedSubviews(backButton, titleLabel, rightItem)
        menuStackView.isLayoutMarginsRelativeArrangement = true
        menuStackView.layoutMargins = .init(top: 0, left: 18, bottom: 0, right: 18)
        menuStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            self.centerConstraint = $0.centerX.equalToSuperview().constraint
            self.leadingConstraint = $0.leading.equalTo(backButton.snp.trailing).offset(10).constraint
            $0.trailing.lessThanOrEqualTo(rightItem.snp.leading).offset(-8)
        }
        centerConstraint?.activate()
        leadingConstraint?.deactivate()
    }
    
    func applyConfiguration(_ vc: UberNavigationConfigurable) {
        titleLabel.text = vc.uberTitle
        titleLabel.font = vc.prefersLargeTitle ? .title1_eb32 : .body1_b18
        
        if vc.alignTitleLeft {
            leadingConstraint?.activate()
            centerConstraint?.deactivate()
        } else {
            centerConstraint?.activate()
            leadingConstraint?.deactivate()
        }
        
        if vc.isVertical {
            menuStackView.axis = .vertical
            menuStackView.distribution = .fill
        } else {
            menuStackView.axis = .horizontal
            menuStackView.distribution = .equalCentering
        }
    }
    
    func setDefaultStyle() {
        titleLabel.text = ""
        titleLabel.font = .body1_b18
        menuStackView.alignment = .center
    }
}
