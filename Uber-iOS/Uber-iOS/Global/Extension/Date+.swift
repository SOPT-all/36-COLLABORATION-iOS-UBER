//
//  Date+.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/22/25.
//

import Foundation

extension Date {    
    func formmatedString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
