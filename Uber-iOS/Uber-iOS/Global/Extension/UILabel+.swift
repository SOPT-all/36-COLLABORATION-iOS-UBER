//
//  UILabel+.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/12/25.
//

import UIKit

extension UILabel {

    func setLabel(
        text: String? = "",
        alignment: NSTextAlignment = .center,
        numberOfLines: Int = 0,
        textColor: UIColor,
        font: UIFont,
        backgroundColor: UIColor? = .clear,
    ) {
        self.text = text
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
    }

}
