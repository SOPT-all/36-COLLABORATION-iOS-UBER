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
    case getSearch  // 검색 기록 조회
    case allDeleteSearch  // 검색 기록 전체 삭제
    case singleDeleteSearch(Double)  // 검색 기록 삭제

    var httpMethod: HTTPMethodType {
        switch self {
        case .taxi, .getSearch:
            .get
        case .location:
            .post
        case .allDeleteSearch, .singleDeleteSearch:
            .delete
        }
    }

    var url: String {
        switch self {
        case .taxi:
            "/uber/v1/taxi"
        case .location:
            "/uber/v1/location"
        case .getSearch:
            "/uber/v1/search"
        case .allDeleteSearch:
            "/uber/v1/search"
        case .singleDeleteSearch(let id):
            "/uber/v1/search/\(id)"
        }
    }

    var headers: [String: String] { defaultHeaders }

}
