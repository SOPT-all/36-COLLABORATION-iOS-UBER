//
//  SearchResponse.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/20/25.
//

struct SearchResponse: Decodable {
    let searchKeywords: [SearchKeyword]
}

struct SearchKeyword: Decodable {
    let id: Int
    let location: String
    let address: String
    let date: String
}

extension SearchKeyword {
    func toEntity() -> SearchKeywordEntity {
        return .init(
            id: self.id,
            location: self.location,
            address: self.address,
            date: self.date
        )
    }
}
