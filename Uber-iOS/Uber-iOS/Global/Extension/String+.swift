//
//  String+.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/14/25.
//

import UIKit

extension String {
    func replaceFont(pattern: String, replaceFont: UIFont) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.font: replaceFont, .foregroundColor: UIColor.primary]
        let attributedString = NSMutableAttributedString(string: self)
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let length = self.count
            let range = NSRange(location: 0, length: length)
            let matches = (regex.matches(in: self, options: [], range: range))
            matches.forEach {
                attributedString.addAttributes(attributes, range: $0.range)
            }
        } catch {
            
        }
        return attributedString
    }
}


