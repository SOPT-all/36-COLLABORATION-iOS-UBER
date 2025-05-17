//
//  UberNavigationController.swift
//  Uber-iOS.
//
//  Created by 권석기 on 5/17/25.
//

import SnapKit
import UIKit

protocol UberNavigationConfigurable {
    // Set navigation title
    var uberTitle: String? { get }
    // Set title size
    var prefersLargeTitle: Bool { get }
    var alignTitleLeft: Bool { get }
    var isVertical: Bool { get }
}

class UberContainerViewController: UIViewController {

    private let navigationBar = UberNavigationBar()
    private let contentContainerView = UIView()

    private var embedNavigationController: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addTarget()
    }

    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(contentContainerView)

        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(56)
        }

        contentContainerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func addTarget() {
        navigationBar.backButton.addTarget(
            self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    func embedNavigationController(_ nav: UINavigationController) {
        embedNavigationController = nav
        nav.delegate = self
        addChild(nav)
        contentContainerView.addSubview(nav.view)
        nav.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        nav.setNavigationBarHidden(true, animated: false)
        didMove(toParent: self)
    }

    private func updateNavigationBar(_ viewController: UIViewController?) {
        guard let vc = viewController else { return }

        if let configurable = vc as? UberNavigationConfigurable {
            navigationBar.applyConfiguration(configurable)
        } else {
            navigationBar.setDefaultStyle()
        }
    }
}

extension UberContainerViewController {
    @objc private func backButtonTapped() {
        guard let nav = embedNavigationController else { return }
        nav.popViewController(animated: true)
    }
}

extension UberContainerViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController, animated: Bool
    ) {
        print(viewController)
        updateNavigationBar(viewController)
    }
}
