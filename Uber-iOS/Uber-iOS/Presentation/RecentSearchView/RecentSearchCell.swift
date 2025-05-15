//
//  RecentSearchCell.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/16/25.
//

import SnapKit
import Then
import UIKit

final class RecentSearchCell: UIView {

    // MARK: - UI Components

    private let containerView = UIView()

    private let dividerView = UIView().then {
        $0.backgroundColor = .graysub
    }

    private let titleLabel = UILabel().then {
        $0.font = .body1_sb18
        $0.textColor = .primary
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }

    private let locationLabel = UILabel().then {
        $0.font = .caption_sb12
        $0.textColor = .sub3
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }

    private let dateLabel = UILabel().then {
        $0.font = .body3_m14
        $0.textColor = .sub3
    }

    let deleteButton = UIButton().then {
        $0.setImage(.delete, for: .normal)
        $0.contentMode = .scaleAspectFit
    }

    private let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
    }

    private let contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
        $0.distribution = .fill
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

    // MARK: - Setup

    private func configure() {
        textStackView.addArrangedSubviews(titleLabel, locationLabel)
        contentStackView.addArrangedSubviews(
            textStackView,
            dateLabel,
            deleteButton
        )
        containerView.addSubviews(
            dividerView,
            contentStackView
        )
        addSubview(containerView)
    }

    private func setConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
            )
        }

        dividerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        textStackView.snp.makeConstraints {
            $0.width.equalTo(243)
        }

        contentStackView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }

        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(24)
        }
    }

    // MARK: - Public API

    func configure(title: String, location: String, date: String) {
        titleLabel.text = title
        locationLabel.text = location
        dateLabel.text = date
    }
}
