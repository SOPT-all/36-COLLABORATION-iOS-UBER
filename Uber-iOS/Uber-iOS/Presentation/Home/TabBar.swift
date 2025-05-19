//
//  TabBar.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/15/25.
//
import UIKit
import SnapKit
import Then

final class TabBar: UIView {

    // MARK: - Properties

    private let topBorder = UIView().then {
        $0.backgroundColor = UIColor.bgGray
    }

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 62
    }

    private let homeButton = TabButton(imageName: "home", title: "홈")
    private let serviceButton = TabButton(imageName: "service", title: "서비스")
    private let activityButton = TabButton(imageName: "activity", title: "활동")
    private let accountButton = TabButton(imageName: "account", title: "계정")

    private var currentSelectedButton: TabButton?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()

        homeButton.setActive(true)
        currentSelectedButton = homeButton

        homeButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        serviceButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        activityButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        accountButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        addSubviews(topBorder, stackView)
        [homeButton, serviceButton, activityButton, accountButton].forEach { stackView.addArrangedSubview($0) }

        topBorder.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(topBorder.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    // MARK: - Actions
    @objc private func tabTapped(_ sender: TabButton) {
        print("🍎 \(sender.title) 탭이 눌렸습니다")
        setTab(sender)
    }

    func setTab(_ selected: TabButton) {
        guard selected != currentSelectedButton else {
            return
        }

        [homeButton, serviceButton, activityButton, accountButton].forEach {
            $0.setActive($0 == selected)
        }
        currentSelectedButton = selected
    }
}


// MARK: - TabButton

final class TabButton: UIButton {
    let title: String

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.iconInactive
        $0.isUserInteractionEnabled = false
    }

    private let titleLabelCustom = UILabel().then {
        $0.font = UIFont.caption_b12
        $0.textColor = UIColor.iconInactive
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = false
    }

    init(imageName: String, title: String) {
        self.title = title
        super.init(frame: .zero)
        setup(imageName: imageName, title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup(imageName: String, title: String) {
        self.setTitle("", for: .normal)
        
        iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        titleLabelCustom.text = title

        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabelCustom]).then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 2
            $0.isUserInteractionEnabled = false
        }

        addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(24)
        }
    }

    // MARK: - State

    func setActive(_ isActive: Bool) {
        let activeColor = isActive ? UIColor.black : UIColor.iconInactive
        iconImageView.tintColor = activeColor
        titleLabelCustom.textColor = activeColor
    }
}
