//
//  MusicRepositorySpy.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

@MainActor
final class MusicRepositorySpy: MusicRepositoryProtocol {
    // MARK: - Properties
    var searchSongsResult: PaginatedSongs = PaginatedSongs(
        resultCount: .zero,
        items: []
    )

    var fetchAlbumSongsResult: [Song] = []

    // MARK: - Methods
    func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs {
        return searchSongsResult
    }

    func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song] {
        return fetchAlbumSongsResult
    }
}
