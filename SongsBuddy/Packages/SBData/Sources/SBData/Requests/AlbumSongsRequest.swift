//
//  AlbumSongsRequest.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation
import SBCore

enum AlbumSongsRequest: URLRequestProtocol {
    case fetch(albumId: Int)

    var path: String {
        return "/lookup"
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetch(let albumId):
            return [
                URLQueryItem(name: "id", value: "\(albumId)"),
                URLQueryItem(name: "entity", value: "song")
            ]
        }
    }
}
