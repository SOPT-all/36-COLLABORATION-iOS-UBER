//
//  ServiceButtonView.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/15/25.
//
import UIKit
import SnapKit
import Then

final class ServiceButtonView: UIView {
    
    var onTap: (() -> Void)?

    // MARK: - UI Components
    private let containerButton = UIButton().then {
        $0.backgroundColor = .bgGray
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .primary
        $0.font = .caption_sb12
        $0.textAlignment = .left
    }

    // MARK: - Init

    init(title: String, imageName: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        iconImageView.image = UIImage(named: imageName)
        setupLayout()
        setupAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(containerButton)
        containerButton.addSubviews(titleLabel, iconImageView)

        containerButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(12)
        }

        iconImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(54)
        }
    }
    
    // MARK: - Action

    private func setupAction() {
        containerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        onTap?()
    }
}
