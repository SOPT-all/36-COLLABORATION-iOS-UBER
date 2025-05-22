//
//  DiscountBannerView.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/15/25.
//
import UIKit
import SnapKit
import Then

final class UberDiscountBannerView: UIView {

    // MARK: - UI Components

    private let containerView = UIView().then {
        $0.backgroundColor = UIColor(red: 237/255, green: 243/255, blue: 255/255, alpha: 1) // 연파랑
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    private let titleLabel = UILabel().then {
        $0.text = "우버 이용료 5000원 할인 받기"
        $0.textColor = .point1
        $0.font = UIFont.body3_b14
    }

    private let nextImageView = UIImageView().then {
        $0.image = UIImage(named: "next")
        $0.tintColor = UIColor.iconInactive
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubviews(titleLabel, nextImageView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        nextImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }
}
