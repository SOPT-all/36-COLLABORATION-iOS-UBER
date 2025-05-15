//
//  NSMutableAttributedString+.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/15/25.
//

import UIKit

extension NSMutableAttributedString {
    func appendImage(image: UIImage) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        self.append(NSAttributedString(attachment: imageAttachment))
        return self
    }
    
    func prependImage(image: UIImage, imageSize: CGSize = CGSize(width: 16, height: 16)) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(
            x: 0,
            y: -2,
            width: imageSize.width,
            height: imageSize.height
        )
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        let result = NSMutableAttributedString(attributedString: imageString)
        
        result.append(NSAttributedString(string: " "))
        result.append(self)
        
        return result
    }
}
