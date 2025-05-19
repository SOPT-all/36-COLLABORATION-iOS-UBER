//
//  SearchService.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/20/25.
//

import Foundation

protocol SearchServiceProtocol {
    func fetchSearchKeywords() async throws -> [SearchKeywordEntity]
}

final class SearchService: SearchServiceProtocol {
    let network = BaseService.shared

    func fetchSearchKeywords() async throws -> [SearchKeywordEntity] {
        do {
            let response: SearchResponse = try await network.request(
                endPoint: .getSearchKeywords
            )
            return response.searchKeywords.map { $0.toEntity() }
        } catch NetworkError.noData {
            return []
        } catch {
            throw error
        }
    }
}
