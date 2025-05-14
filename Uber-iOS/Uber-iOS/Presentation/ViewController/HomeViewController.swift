//
//  HomeViewController.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/14/25.
//
import UIKit
import SnapKit
import Then

final class HomeViewController: BaseViewController {

    private let goToNextButton = UIButton().then {
        $0.setTitle("다음 화면으로", for: .normal)
        $0.applyUberStyle()
    }

    // MARK: - LifeCycle

    override func configure() {
        super.configure()
        view.backgroundColor = .white
        addSubviews(goToNextButton)
        
        goToNextButton.addTarget(self, action: #selector(goToNextTapped), for: .touchUpInside)
    }

    override func setConstraints() {
        goToNextButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(34)
        }
    }

    // MARK: - Action

    @objc private func goToNextTapped() {
        let nextVC = ViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
