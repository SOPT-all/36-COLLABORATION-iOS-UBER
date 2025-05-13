//
//  ReservationInfoViewController.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

import SnapKit

// MARK: - Properties

final class ReservationInfoViewController: UIViewController {
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentStackView = UIStackView().then {
        $0.backgroundColor = .bgGray
        $0.axis = .vertical
        $0.spacing = 8
    }
}

// MARK: - LifeCycle

extension ReservationInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setLayout()
    }
}

// MARK: - Layout

extension ReservationInfoViewController {
    private func addSubViews() {
        scrollView.addSubview(contentStackView)
        [scrollView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
}

#Preview {
    ReservationInfoViewController()
}
