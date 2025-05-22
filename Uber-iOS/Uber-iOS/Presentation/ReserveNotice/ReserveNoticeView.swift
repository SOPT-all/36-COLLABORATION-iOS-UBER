//
//  ReserveNoticeView.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/15/25.
//

import SnapKit
import Then
import UIKit

final class ReserveNoticeView: UIView {

    // MARK: - Layout Constants
    private enum Layout {
        static let verticalPadding: CGFloat = 12
        static let horizontalLeading: CGFloat = 32
        static let horizontalTrailing: CGFloat = 16
        static let iconSize: CGFloat = 24
        static let stackSpacing: CGFloat = 20
    }

    // MARK: - Properties

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let contentLabel = UILabel().then {
        $0.font = .body3_sb14
        $0.textColor = .sub2
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
        $0.setTextWithLineHeight(text: $0.text, lineHeight: -2)
    }

    private let contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Layout.stackSpacing
        $0.alignment = .center
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
        addSubviews(contentStackView)
        contentStackView.addArrangedSubviews(iconImageView, contentLabel)
    }

    // MARK: - Layout

    private func setConstraints() {
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(
                    top: Layout.verticalPadding,
                    left: Layout.horizontalLeading,
                    bottom: Layout.verticalPadding,
                    right: Layout.horizontalTrailing
                )
            )
        }
    }

    // MARK: - Public Configurator
    func configure(_ style: ReserveNoticeType) {
        switch style {

        case .calendar:
            iconImageView.image = UIImage(resource: .calender)
            contentLabel.text = "최대 90일 전부터 차량을 예약할 수 있습니다."

        case .sandclock:
            iconImageView.image = UIImage(resource: .sandclock)
            contentLabel.text = "이용 시 대기 시간이 요금에 포함되어 있습니다."

        case .wallet:
            iconImageView.image = UIImage(resource: .wallet)
            contentLabel.text = "픽업 1시간 전까지 무료로 취소하세요. 예약 수수료 적용됩니다."
        }
    }
}
