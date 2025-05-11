//
//  UIFont+.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/11/25.
//
import UIKit

// MARK: - 폰트 이름 상수화
enum FontName: String {
    case suitExtraBold = "SUIT-ExtraBold"
    case suitBold = "SUIT-Bold"
    case suitSemiBold = "SUIT-SemiBold"
    case suitMedium = "SUIT-Medium"
}

// MARK: - UIFont 확장
extension UIFont {

    /// 폰트가 존재하지 않는경우 기본 폰트
    static func custom(_ font: FontName, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    // MARK: - Head
    static let head_eb48 = custom(.suitExtraBold, size: 48)

    // MARK: - Title
    static let title1_eb32 = custom(.suitExtraBold, size: 32)
    static let title2_sb22 = custom(.suitSemiBold, size: 22)
    static let title3_eb20 = custom(.suitExtraBold, size: 20)
    static let title3_b20 = custom(.suitBold, size: 20)

    // MARK: - Body 1
    static let body1_eb18 = custom(.suitExtraBold, size: 18)
    static let body1_b18 = custom(.suitBold, size: 18)
    static let body1_sb18 = custom(.suitSemiBold, size: 18)

    // MARK: - Body 2
    static let body2_eb16 = custom(.suitExtraBold, size: 16)
    static let body2_sb16 = custom(.suitSemiBold, size: 16)
    static let body2_m16 = custom(.suitMedium, size: 16)

    // MARK: - Body 3
    static let body3_b14 = custom(.suitBold, size: 14)
    static let body3_sb14 = custom(.suitSemiBold, size: 14)
    static let body3_m14 = custom(.suitMedium, size: 14)

    // MARK: - Caption
    static let caption_b12 = custom(.suitBold, size: 12)
    static let caption_sb12 = custom(.suitSemiBold, size: 12)
    static let caption_m12 = custom(.suitMedium, size: 12)
}
