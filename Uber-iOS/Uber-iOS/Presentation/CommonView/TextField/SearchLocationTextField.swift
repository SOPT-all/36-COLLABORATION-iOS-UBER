//
//  SearchLocationTextField.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/17/25.
//
import UIKit
import SnapKit
import Then

final class SearchLocationTextField: UIView {

    // MARK: - UI Components

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .iconInactive
    }

    let textField = UITextField().then {
        $0.borderStyle = .none
        $0.backgroundColor = .bgGray
        $0.font = .body2_m16
        $0.textColor = UIColor.primary
        $0.clearButtonMode = .whileEditing
    }

    // MARK: - Init

    init(icon: UIImage?, placeholder: String) {
        super.init(frame: .zero)
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        setPlaceholder(placeholder)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        layer.cornerRadius = 30
        addSubviews(iconImageView, textField)

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }

        textField.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }

    // MARK: - Style

    private func setPlaceholder(_ text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: UIColor.iconInactive,
                .font: UIFont.body2_m16
            ]
        )
    }
}
