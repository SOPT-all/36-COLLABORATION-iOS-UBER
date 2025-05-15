//
//  ReserveInfoView.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/15/25.
//

import SnapKit
import Then
import UIKit

final class ReserveInfoView: UIView {

    // MARK: - Properties

    private let iconContainerView = UIView().then {
        $0.backgroundColor = .bgGray
        $0.clipsToBounds = true
    }

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let subTitleLabel = UILabel().then {
        $0.font = .body3_m14
        $0.textColor = .sub1
    }

    private let titleLabel = UILabel().then {
        $0.font = .body1_b18
        $0.textColor = .primary
    }

    private let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
    }

    private let additionalTaxiContainerView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.isHidden = true
    }

    private let mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
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
        backgroundColor = .bgWhite
        layer.cornerRadius = 12

        layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        preservesSuperviewLayoutMargins = false

        iconContainerView.addSubview(iconImageView)
        textStackView.addArrangedSubviews(subTitleLabel, titleLabel)
        contentStackView.addArrangedSubviews(
            iconContainerView,
            textStackView
        )
        mainStackView.addArrangedSubviews(
            contentStackView,
            additionalTaxiContainerView
        )

        addSubview(mainStackView)
    }

    // MARK: - Layout

    private func setConstraints() {
        iconContainerView.snp.makeConstraints {
            $0.width.height.equalTo(64)
        }
        iconContainerView.layer.cornerRadius = 64 / 2

        iconImageView.snp.makeConstraints {
            $0.center.equalTo(iconContainerView)
            $0.width.height.equalTo(36)
        }

        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(layoutMarginsGuide)
        }
    }

    // MARK: - Public Configurator

    func configure(_ style: ReserveInfoStyle) {
        switch style {
        case let .info(icon, title, subtitle):
            setContent(icon: icon, title: title, subtitle: subtitle)
            applyBorder(width: 0, color: nil)
            iconImageView.tintColor = nil
            additionalTaxiContainerView.isHidden = true

        case let .inactive(icon, title, subtitle):
            setContent(icon: icon, title: title, subtitle: subtitle)
            applyBorder(width: 1, color: UIColor.bgGray.cgColor)
            iconImageView.tintColor = .iconInactive
            iconImageView.image = iconImageView.image?.withRenderingMode(
                .alwaysTemplate
            )
            additionalTaxiContainerView.isHidden = true

        case let .active(icon, title, subtitle, views):
            setContent(icon: icon, title: title, subtitle: subtitle)
            applyBorder(width: 1, color: UIColor.btnActive.cgColor)
            iconImageView.tintColor = nil
            additionalTaxiContainerView.isHidden = false
            addAdditionalViews(views)
        }
    }
    
    // MARK: - Helper

    private func setContent(icon: UIImage?, title: String, subtitle: String) {
        iconImageView.image = icon
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }

    private func applyBorder(width: CGFloat, color: CGColor?) {
        layer.borderWidth = width
        layer.borderColor = color
    }

    private func addAdditionalViews(_ views: [UIView]) {
        additionalTaxiContainerView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        views.forEach { additionalTaxiContainerView.addArrangedSubview($0) }
    }

}
