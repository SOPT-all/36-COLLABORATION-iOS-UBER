//
//  VehicleEntity.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/21/25.
//

import Foundation

struct VehicleEntity: Decodable {
    let taxiList: [VehicleTypeEntity]
    let caseTaxiList: [VehicleTypeEntity]
}

struct VehicleTypeEntity: Decodable {
    let id: Int
    let type: String
    let min: Int
    let max: Int
    let guest: Int
    let comment: String
    let image: String
}
