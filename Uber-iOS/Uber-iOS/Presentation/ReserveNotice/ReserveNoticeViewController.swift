//
//  ReserveNoticeViewController.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/21/25.
//

import SnapKit
import Then
import UIKit

final class ReserveNoticeViewController: BaseViewController {

    // MARK: - Layout Constants

    private enum Layout {
        static let sideInset: CGFloat = 16
        static let topInset: CGFloat = 10
        static let fieldSpacing: CGFloat = 8
        static let sectionPadding: CGFloat = 20
        static let separator1Height: CGFloat = 6
        static let separator2Height: CGFloat = 1
        static let infoSpacing: CGFloat = 8
    }

    // MARK: - Data Models

    private let placeholders = [
        (icon: UIImage(resource: .departure), placeholder: "출발지 검색"),
        (icon: UIImage(resource: .place), placeholder: "도착지 검색"),
    ]

    private let infoStyles: [ReserveInfoStyle] = [
        .info(
            icon: UIImage(resource: .icFlight32),
            title: "공항 갈 때",
            subtitle: "캐리어 걱정 없이 쾌적하게 이동"
        ),
        .info(
            icon: UIImage(resource: .icChildCare32),
            title: "아기와 함께 할 때",
            subtitle: "카시트로 안전하게, 걱정없는 이동"
        ),
        .info(
            icon: UIImage(resource: .icDirectionsCar32),
            title: "장거리 운전",
            subtitle: "렌터카 빌릴 필요 없이 편안하게"
        ),
        .info(
            icon: UIImage(resource: .icGTranslate32),
            title: "외국어 가능 기사님으로 문제없는 의사소통",
            subtitle: "언어 문제 없이 이동"
        ),
    ]

    // MARK: - UI

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.alwaysBounceVertical = true
    }

    private let contentView = UIView()

    private lazy var fieldsStack = UIStackView(arrangedSubviews: placeFields)
        .then {
            $0.axis = .vertical
            $0.spacing = Layout.fieldSpacing
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(
                top: 0,
                left: Layout.sideInset,
                bottom: 0,
                right: Layout.sideInset
            )
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchFieldTapped))
            $0.addGestureRecognizer(tapGesture)
        }

    private lazy var placeFields: [SearchLocationTextField] = placeholders.map {
        SearchLocationTextField(icon: $0.icon, placeholder: $0.placeholder)
    }

    private let separator1 = UIView().then {
        $0.backgroundColor = .bgGray

    }

    private lazy var noticesStack = UIStackView(arrangedSubviews: noticeViews)
        .then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
        }

    private lazy var noticeViews: [ReserveNoticeView] = [
        .calendar, .sandclock, .wallet,
    ].map { style in
        ReserveNoticeView().then { view in
            view.configure(style)
        }
    }

    private let separator2 = UIView().then {
        $0.backgroundColor = .graysub
    }

    private let noticeText = UILabel().then {
        $0.text = "다양한 상황에서\n예약 기능을 이용해보세요"
        $0.font = .title3_eb20
        $0.textColor = .primary
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    private lazy var infoStack = UIStackView(arrangedSubviews: infoViews).then {
        $0.axis = .vertical
        $0.spacing = Layout.infoSpacing
        $0.backgroundColor = .bgGray

        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(
            top: 20,
            left: 16,
            bottom: 20,
            right: 16
        )
    }

    private lazy var infoViews: [ReserveInfoView] = infoStyles.map { style in
        let view = ReserveInfoView()
        view.configure(style)
        return view
    }

    override func configure() {
        super.configure()
        setupHierarchy()
        configureTextField()
    }

    // MARK: - Layout

    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            fieldsStack,
            separator1,
            noticesStack,
            separator2,
            noticeText,
            infoStack
        )
    }

    private func configureTextField() {
        placeFields.forEach { field in
            field.backgroundColor = .bgGray
            field.isUserInteractionEnabled = false
            field.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }
    }

    override func setConstraints() {

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        fieldsStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(Layout.topInset)
        }

        separator1.snp.makeConstraints {
            $0.top.equalTo(fieldsStack.snp.bottom).offset(Layout.sectionPadding)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Layout.separator1Height)
        }

        noticesStack.snp.makeConstraints {
            $0.top.equalTo(separator1.snp.bottom).offset(Layout.sectionPadding)
            $0.leading.trailing.equalToSuperview()
        }

        separator2.snp.makeConstraints {
            $0.top.equalTo(noticesStack.snp.bottom).offset(
                Layout.sectionPadding
            )
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(Layout.separator2Height)
        }

        noticeText.snp.makeConstraints {
            $0.top.equalTo(separator2.snp.bottom).offset(Layout.sectionPadding)
            $0.leading.trailing.equalToSuperview().inset(Layout.sideInset)
        }

        infoStack.snp.makeConstraints {
            $0.top.equalTo(noticeText.snp.bottom).offset(Layout.sectionPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UI Action

extension ReserveNoticeViewController {
    @objc private func searchFieldTapped() {
        let recentSearchVC = RecentSearchViewController()
        navigationController?.pushViewController(recentSearchVC, animated: true)
    }
}

// MARK: - Configure navigation

extension ReserveNoticeViewController: UberNavigationConfigurable {
    var uberTitle: String? { "예약하기" }
    var prefersLargeTitle: Bool { true }
    var alignTitleLeft: Bool { true }
}
