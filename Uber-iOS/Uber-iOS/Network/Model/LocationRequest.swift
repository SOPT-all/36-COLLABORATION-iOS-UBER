//
//  LocationRequest.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/21/25.
//

import Foundation

struct LocationRequest: Encodable {
    let departures: String
    let destination: String
}
