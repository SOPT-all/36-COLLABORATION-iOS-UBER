//
//  VehicleService.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/21/25.
//

protocol VehicleServiceProtocol {
    func fetchVehicleTypes()
}

final class VehicleService: VehicleServiceProtocol {
       
    private let network = BaseService.shared
    
    func fetchVehicleTypes() {
        
    }
}
