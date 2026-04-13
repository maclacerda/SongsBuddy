//
//  SearchSongsRequest.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import SBCore

enum SearchSongsRequest: URLRequestProtocol {
    case search(
        term: String,
        offset: Int,
        limit: Int
    )

    var path: String {
        return "/search"
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case let .search(term, offset, limit):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "entity", value: "song"),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        }
    }
}
