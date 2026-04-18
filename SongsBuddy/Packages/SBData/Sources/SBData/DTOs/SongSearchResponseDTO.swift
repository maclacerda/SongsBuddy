//
//  SongSearchResponseDTO.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Represents the iTunes Search API response for song search.
struct SongSearchResponseDTO: Decodable {
    let resultCount: Int
    let results: [SongDTO]
}

/// Represents a song item returned by the iTunes Search API.
struct SongDTO: Decodable {
    let trackId: Int?
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let previewUrl: String?
    let collectionName: String?
    let collectionId: Int?
}
