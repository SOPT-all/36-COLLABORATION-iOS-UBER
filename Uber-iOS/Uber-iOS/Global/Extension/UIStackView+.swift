//
//  UIStackView+.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/12/25.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }

}
