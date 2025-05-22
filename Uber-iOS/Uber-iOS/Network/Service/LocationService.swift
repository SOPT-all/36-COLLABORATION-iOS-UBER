//
//  LocationService.swift
//  Uber-iOS
//
//  Created by 선영주 on 5/21/25.
//

import Foundation

final class LocationService {
    let network = BaseService.shared

    func sendLocation(departures: String, destination: String) async throws {
        let requestBody = LocationRequest(departures: departures, destination: destination)

        do {
            let _: BaseResponse<Empty> = try await network.request(endPoint: .location, body: requestBody)
        } catch NetworkError.noData {
            // noData 에러는 무시하고 성공 처리
        } catch NetworkError.responseDecodingError {
        } catch {
            throw error
        }
    }
}

// 빈 데이터용 타입
struct Empty: Decodable {}
