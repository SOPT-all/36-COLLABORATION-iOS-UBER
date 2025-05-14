//
//  UIButton+.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/14/25.
//
import UIKit

extension UIButton {

    func applyUberStyle() {
        self.do {
            $0.backgroundColor = UIColor.btnActive
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .body2_sb16
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)
        }
    }
}
