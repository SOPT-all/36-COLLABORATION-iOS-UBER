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
        backgroundColor: UIColor? = .clear
    ) {
        self.text = text
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
    }
    
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let range = NSRange(location: 0, length: text.count)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 2
            ]
            
            var mutableAttrString = NSMutableAttributedString(string: text)
            
            // 기존에 AttributedString이 존재한다면 덮어쓰기
            if let attrString = self.attributedText {
                mutableAttrString = NSMutableAttributedString(attributedString: attrString)
            }
            
            mutableAttrString.addAttributes(attributes, range: range)

            self.attributedText = mutableAttrString
        }
    }
}
