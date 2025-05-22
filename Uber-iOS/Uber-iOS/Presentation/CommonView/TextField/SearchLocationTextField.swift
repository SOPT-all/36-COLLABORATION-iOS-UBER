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
        $0.backgroundColor = .clear
        $0.font = .body2_m16
        $0.textColor = .primary
        $0.returnKeyType = .done
    }

    private let clearButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "xmark"), for: .normal)
        $0.tintColor = .iconInactive
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 12
        $0.isHidden = true
        $0.clipsToBounds = true
    }

    // MARK: - Init

    init(icon: UIImage?, placeholder: String) {
        super.init(frame: .zero)
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        setPlaceholder(placeholder)
        setupLayout()
        setupAction()
        applyInitialStyle()
        
        self.isUserInteractionEnabled = true
        self.textField.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        backgroundColor = .bgGray
        layer.cornerRadius = 30
        layer.borderWidth = 0
        backgroundColor = .bgGray

        addSubviews(iconImageView, textField, clearButton)

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }

        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }

        textField.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.trailing.equalTo(clearButton.snp.leading).offset(-8)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }

    // MARK: - Action & Style

    private func setupAction() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }

    private func applyInitialStyle() {
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = .bgGray
    }

    private func applyFilledStyle() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.bgGray.cgColor
        backgroundColor = .bgWhite
        textField.textColor = .black
    }

    @objc private func clearText() {
        textField.text = ""
        clearButton.isHidden = true
        applyInitialStyle()
    }

    @objc private func textFieldDidChange() {
        let isEmpty = textField.text?.isEmpty ?? true
        clearButton.isHidden = isEmpty
        isEmpty ? applyInitialStyle() : applyFilledStyle()
    }

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

// MARK: - UITextFieldDelegate

extension SearchLocationTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidChange()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidChange()
    }
}
