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

    func deleteSearchKeyword(id: Int) async throws {
        do {
            _ =
                try await BaseService.shared
                .request(endPoint: .deleteSingleSearchKeyword(id))
                as EmptyResponse
        } catch NetworkError.noData,
            NetworkError.responseDecodingError
        {
            print("null 값은 정상 처리")
        } catch {
            print("통신 자체에 실패")
        }
    }

    func deleteAllSearchKeywords() async {
        do {
            let _: EmptyResponse = try await BaseService.shared
                .request(endPoint: .deleteAllSearchKeywords)
        } catch NetworkError.noData,
            NetworkError.responseDecodingError
        {
            print("null 값은 정상 처리")
        } catch {
            print("전체 삭제 중 에러:", error)
        }
    }
}
