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
    let guests: Int
    let comment: String
    let image: String
    
    init(id: Int, type: String, min: Int, max: Int, guests: Int, comment: String, image: String) {
        self.id = id
        self.type = type
        self.min = min
        self.max = max
        self.guests = guests
        self.comment = comment
        self.image = image
    }
    
    init() {
        self.id = 0
        self.type = ""
        self.min = 0
        self.max = 0
        self.guests = 0
        self.comment = ""
        self.image = ""
    }
}
