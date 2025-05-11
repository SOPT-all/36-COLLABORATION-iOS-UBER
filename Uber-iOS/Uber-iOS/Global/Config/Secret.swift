//
//  Secret.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/11/25.
//

import Foundation

enum Secret {
    static let baseURL: String = {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            assertionFailure("BASE_URL이 없음")
            return ""
        }
        return url
    }()
}
