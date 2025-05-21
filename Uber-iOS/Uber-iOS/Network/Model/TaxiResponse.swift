//
//  TaxiResponse.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/21/25.
//

import Foundation

struct TaxiResponse: Decodable {
    let taxiList: [TaxiInfoResponse]
    let caseTaxiList: [TaxiInfoResponse]
}

struct TaxiInfoResponse: Decodable {
    let id: Int
    let type: String
    let min: Int
    let max: Int
    let guests: Int
    let comment: String
    let image: String
}

extension Array where Element == TaxiInfoResponse {
    func toEntity() -> [TaxiInfoEntity] {
        self.map { .init(id: $0.id,
                         type: $0.type,
                         min: $0.min,
                         max: $0.max,
                         guests: $0.guests,
                         comment: $0.comment,
                         image: $0.image) }
    }
}
