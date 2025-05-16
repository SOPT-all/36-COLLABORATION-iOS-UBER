//
//  BaseViewController.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/12/25.
//
import UIKit

import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    // MARK: - Configure UI
    
    func configure() {
        view.backgroundColor = UIColor.bgWhite
    }
    
    // MARK: - Layout
    
    func setConstraints() {
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view.addSubview($0) }
    }
}
