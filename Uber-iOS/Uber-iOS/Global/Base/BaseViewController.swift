//
//  BaseViewController.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/12/25.
//
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        setupHeader()
    }
    
    // MARK: - Configure UI
    
    func configure() {
        view.backgroundColor = UIColor.bgWhite
    }
    
    // MARK: - Layout
    
    func setConstraints() {}
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view.addSubview($0) }
    }
    
    private func setupHeader() {
        guard let configuralbe = self as? UberNavigationConfigurable else {
            return
        }
        let navBar = UberNavigationBar()
        navBar.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(navBar)
        
        navBar.applyConfiguration(configuralbe)
        
        navBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-56)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        additionalSafeAreaInsets.top = 56
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


