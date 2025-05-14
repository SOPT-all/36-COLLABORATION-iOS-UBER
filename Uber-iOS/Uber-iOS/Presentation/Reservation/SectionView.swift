//
//  SectionView.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

import SnapKit

final class SectionView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.setLabel(textColor: .primary, font: .body1_eb18)
    }
    private let subtitleLabel = UILabel().then {
        $0.setLabel(textColor: .sub2, font: .caption_m12)
    }
    
    private let topContainerView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4.5
    }
    
    private let bottomContainer = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let contentView = UIStackView().then {
        $0.axis = .vertical
    }
    
    init(title: String, subtitle: String?, content: UIView, contentEdge: UIEdgeInsets) {
        super.init(frame: .zero)
        setupView(title: title, subtitle: subtitle, content: content, contentEdge: contentEdge)
    }
    
    convenience init(title: String, subtitle: String?, content: UIView) {
        self.init(title: title, subtitle: subtitle, content: content, contentEdge: UIEdgeInsets())
    }
    
    convenience init(title: String, content: UIView) {
        self.init(title: title, subtitle: nil, content: content, contentEdge: UIEdgeInsets())
    }
    
    convenience init(title: String, content: UIView, contentEdge: UIEdgeInsets) {
        self.init(title: title, subtitle: nil, content: content, contentEdge: contentEdge)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String, subtitle: String?, content: UIView, contentEdge: UIEdgeInsets) {
        backgroundColor = .white
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        if subtitle != nil {
            topContainerView.addArrangedSubviews(titleLabel, subtitleLabel)
        } else {
            topContainerView.addArrangedSubview(titleLabel)
        }
        
        topContainerView.isLayoutMarginsRelativeArrangement = true
        topContainerView.layoutMargins = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        
        bottomContainer.addArrangedSubview(content)
        bottomContainer.isLayoutMarginsRelativeArrangement = true
        bottomContainer.layoutMargins = contentEdge
        bottomContainer.layoutMargins.bottom += 10
        
        addSubview(contentView)
        
        contentView.addArrangedSubviews(topContainerView, bottomContainer)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
