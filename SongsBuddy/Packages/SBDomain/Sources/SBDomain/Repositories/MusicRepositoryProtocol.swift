//
//  MusicRepositoryProtocol.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Defines the repository contract for music-related operations.
public protocol MusicRepositoryProtocol: Sendable {
    /// Searches songs by a given search term using pagination parameters.
    func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs

    /// Fetches all songs for a given album identifier.
    func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song]
}
