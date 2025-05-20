//
//  BaseResponse.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/19/25.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: Double
    let msg: String?
    let data: T?
}
