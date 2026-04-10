//
//  SearchSongsRequest.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import SBCore

enum SearchSongsRequest: URLRequestProtocol {
    case search(term: String)

    var path: String {
        return "/search"
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let term):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "entity", value: "song"),
                URLQueryItem(name: "limit", value: "20")
            ]
        }
    }
}
