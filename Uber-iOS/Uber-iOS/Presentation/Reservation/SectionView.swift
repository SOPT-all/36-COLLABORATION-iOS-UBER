//
//  SectionView.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

import SnapKit

final class SectionView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let contentView = UIView()
    
    init(title: String, subtitle: String?, content: UIView, edgeInset: UIEdgeInsets = UIEdgeInsets()) {
        super.init(frame: .zero)
        setupView()
        configure(title: title, subtitle: subtitle, content: content, edgeInset: edgeInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        
        backgroundColor = .white
        
        [titleLabel, subtitleLabel, contentView].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(10)
        }
        
        var contentTopAnchor: ConstraintItem
        var contentTopOffset: CGFloat
        
        if subtitleLabel.text != nil {
            contentTopAnchor = subtitleLabel.snp.bottom
            contentTopOffset = 4.5
            
            subtitleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(25)
                $0.top.equalTo(titleLabel.snp.bottom).offset(4.5)
            }
        } else {
            contentTopAnchor = titleLabel.snp.bottom
            contentTopOffset = 16
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(contentTopAnchor).offset(contentTopOffset)
        }
        
    }
    
    private func configure(title: String, subtitle: String?, content: UIView, edgeInset: UIEdgeInsets) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        setupView()
        
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        contentView.addSubview(content)
        content.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(edgeInset.left)
            $0.trailing.equalToSuperview().inset(edgeInset.right)
            $0.top.equalToSuperview().inset(edgeInset.top)
            $0.bottom.equalToSuperview().inset(edgeInset.bottom)
        }
    }
}
