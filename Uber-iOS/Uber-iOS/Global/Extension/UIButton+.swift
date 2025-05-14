//
//  UIButton+.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/14/25.
//
import UIKit

extension UIButton {

    enum UberStyle {
        case blackMain
        case whiteSub
        
    }

    func applyUberStyle(_ style: UberStyle) {
        switch style {
        case .blackMain:
            self.do {
                $0.backgroundColor = UIColor.btnActive
                $0.setTitleColor(.white, for: .normal)
                $0.titleLabel?.font = .body2_sb16
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
                $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)
            }
        case .whiteSub:
            self.do {
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
                $0.titleLabel?.font = .body2_sb16
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.black.cgColor
                $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)
            }
        }
    }
}
