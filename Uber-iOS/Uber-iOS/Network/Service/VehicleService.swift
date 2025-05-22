//
//  VehicleService.swift
//  Uber-iOS
//
//  Created by 권석기 on 5/21/25.
//

protocol VehicleServiceProtocol {
    func fetchVehicleTypes() async throws -> TaxiEntity
}

final class VehicleService: VehicleServiceProtocol {
    
    private let network = BaseService.shared
    
    func fetchVehicleTypes() async throws -> TaxiEntity {
        do {
            let response: TaxiResponse = try await network.request(endPoint: .taxi)
            return .init(taxiList: response.taxiList.toEntity(), caseTaxiList: response.caseTaxiList.toEntity())
        } catch {
            throw error
        }
    }
}
