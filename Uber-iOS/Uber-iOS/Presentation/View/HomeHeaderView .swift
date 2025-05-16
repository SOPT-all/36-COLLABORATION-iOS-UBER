//
//  HomeHeaderView .swift
//  Uber-iOS
//
//  Created by 선영주 on 5/15/25.
//
import UIKit
import SnapKit
import Then

final class HomeHeaderView: UIView {

    // MARK: - UI Components

    private let titleLabel = UILabel().then {
        $0.text = "어디 가실 예정이세요?"
        $0.textColor = .black
        $0.font = UIFont.title1_eb32
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "다양한 상황에서 차량을 불러보세요."
        $0.textColor = UIColor.sub2
        $0.font = UIFont.body2_m16
        $0.textAlignment = .left
        $0.numberOfLines = 1
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
        addSubviews(titleLabel, descriptionLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

