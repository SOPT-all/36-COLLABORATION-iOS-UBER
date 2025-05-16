//
//  VehicleSelectionViewController.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/16/25.
//

import UIKit

import SnapKit

final class VehicleSelectionViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var contentStackView = UIStackView().then {
        $0.backgroundColor = .bgGray
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    // MARK: - Layout
    
    override func configure() {
        scrollView.addSubview(contentStackView)
        addSubviews(scrollView)
    }
    
    override func setConstraints() {
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

// MARK: - LifeCycle

extension VehicleSelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#Preview {
    VehicleSelectionViewController()
}
