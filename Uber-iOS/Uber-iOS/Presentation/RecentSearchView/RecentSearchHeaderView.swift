//
//  RecentSearchHeaderView.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/16/25.
//

import SnapKit
import Then
import UIKit

final class RecentSearchHeaderView: UIView {

    // MARK: - Properties

    private let iconImageView = UIImageView().then {
        $0.image = .time
        $0.contentMode = .scaleAspectFit
    }

    private let recentSearchLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = .body3_sb14
        $0.textColor = .sub2
    }

    let allDeleteLabel = UIButton(type: .system).then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.point2, for: .normal)
        $0.titleLabel?.font = .caption_m12
    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    private func configure() {
        addSubviews(iconImageView, recentSearchLabel, allDeleteLabel)
    }

    // MARK: - Layout

    private func setConstraints() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        recentSearchLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(24)
            $0.centerY.equalToSuperview()
        }

        allDeleteLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

}
