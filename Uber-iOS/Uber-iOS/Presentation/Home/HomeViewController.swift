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

    private let headerView = HomeHeaderView()
    
    private let carButton = ServiceButtonView(title: "차량 서비스", imageName: "car")
    private let calendarButton = ServiceButtonView(title: "예약", imageName: "calendar")
    
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [carButton, calendarButton]).then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }
    
    private let uberDiscountBanner = UberDiscountBannerView()
    private let reserveBannerView = ReserveBannerView()
    private let tabBar = TabBar()

    // MARK: - LifeCycle

    override func configure() {
        super.configure()
        view.addSubview(headerView)
        view.addSubview(buttonStackView)
        view.addSubview(uberDiscountBanner)
        view.addSubview(reserveBannerView)
        view.addSubview(tabBar)
        
        calendarButton.onTap = { [weak self] in
            let reserveNoticeVC = ReserveNoticeViewController()
            self?.navigationController?.pushViewController(reserveNoticeVC, animated: true)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(93)
        }
        
        uberDiscountBanner.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        reserveBannerView.snp.makeConstraints {
            $0.top.equalTo(uberDiscountBanner.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(153)
        }

        tabBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(85)
        }
    }
}
