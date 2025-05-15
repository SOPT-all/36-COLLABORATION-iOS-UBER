//
//  SectionView.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

import SnapKit

final class SectionView: UIView {
    
    var headerAxis: NSLayoutConstraint.Axis {
        get {
            topContainerView.axis
        } set {
            topContainerView.axis = newValue
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.setLabel(alignment: .left, textColor: .primary, font: .body1_eb18)
    }
    
    private let subtitleLabel = UILabel().then {
        $0.setLabel(alignment: .left, textColor: .sub2, font: .caption_m12)
    }
    
    private let topContainerView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4.5
    }
    
    private let bottomContainer = UIView()
    
    private let contentView = UIStackView().then {
        $0.axis = .vertical
    }
    
    init(title: String, subtitle: NSMutableAttributedString?, content: UIView, contentEdge: UIEdgeInsets) {
        super.init(frame: .zero)
        setupView(title: title, subtitle: subtitle, content: content, contentEdge: contentEdge)
    }
    
    convenience init(title: String, subtitle: NSMutableAttributedString?, content: UIView) {
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
    
    private func setupView(title: String, subtitle: NSMutableAttributedString?, content: UIView, contentEdge: UIEdgeInsets) {
        backgroundColor = .white
        titleLabel.text = title
        subtitleLabel.attributedText = subtitle        
        titleLabel.setTextWithLineHeight(text: title, lineHeight: 36)
        
        // Set topContainer
        
        if subtitle != nil {
            topContainerView.addArrangedSubviews(titleLabel, subtitleLabel)
        } else {
            topContainerView.addArrangedSubview(titleLabel)
        }
        
        topContainerView.isLayoutMarginsRelativeArrangement = true
        topContainerView.layoutMargins = UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25)
        topContainerView.layoutMargins.top += 10
        
        // Set bottomContainer
        
        bottomContainer.addSubview(content)
        
        content.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(contentEdge.left)
            $0.top.equalToSuperview().inset(contentEdge.top)
            $0.bottom.equalToSuperview().inset(contentEdge.bottom + 10)
            $0.trailing.equalToSuperview().inset(contentEdge.right)
        }
        
        // Set Container
        
        addSubview(contentView)
        contentView.addArrangedSubviews(topContainerView, bottomContainer)
        topContainerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
