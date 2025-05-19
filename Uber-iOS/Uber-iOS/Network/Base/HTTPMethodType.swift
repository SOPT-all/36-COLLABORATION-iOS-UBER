//
//  HTTPMethodType.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/19/25.
//

import Foundation

enum HTTPMethodType {
    case get
    case post
    case delete

    var key: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .delete:
            "DELETE"
        }
    }
}

let defaultHeaders = ["Content-Type": "application/json"]
