//
//  UIView+.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/12/25.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

}
