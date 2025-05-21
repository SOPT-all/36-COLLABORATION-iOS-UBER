//
//  EndPoint.swift
//  Uber-iOS
//
//  Created by 조휘원 on 5/19/25.
//

import Foundation

enum EndPoint {
    case taxi  // 택시 종류 반환
    case location  // 출발지, 목적지 저장
    case getSearchKeywords  // 검색 기록 조회
    case deleteAllSearchKeywords  // 검색 기록 전체 삭제
    case deleteSingleSearchKeyword(Int)  // 검색 기록 삭제

    var httpMethod: HTTPMethodType {
        switch self {
        case .taxi, .getSearchKeywords:
            .get
        case .location:
            .post
        case .deleteAllSearchKeywords, .deleteSingleSearchKeyword:
            .delete
        }
    }

    var url: String {
        switch self {
        case .taxi:
            "/uber/v1/taxi"
        case .location:
            "/uber/v1/location"
        case .getSearchKeywords:
            "/uber/v1/search"
        case .deleteAllSearchKeywords:
            "/uber/v1/search"
        case .deleteSingleSearchKeyword(let id):
            "/uber/v1/search/\(id)"
        }
    }

    var headers: [String: String] { defaultHeaders }

}
