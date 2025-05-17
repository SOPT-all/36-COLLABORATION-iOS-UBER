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
    
    private let menuStackView = UIStackView().then {
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
    }
    
    func setBackButtonVisible(_ visible: Bool) {
        if visible {
            backButton.alpha = 0
        } else {
            backButton.alpha = 1
        }
    }
    
    func setNavigationTitle(_ title: String?) {
        titleLabel.text = title
    }
}
