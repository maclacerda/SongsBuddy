//
//  MusicRepositorySpy.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/15/26.
//

import Foundation
import SBDomain

@MainActor
final class MusicRepositorySpy: MusicRepositoryProtocol {
    // MARK: - Properties
    private(set) var searchSongsCallCount: Int = .zero

    var searchSongsResult: PaginatedSongs = PaginatedSongs(
        resultCount: .zero,
        items: []
    )

    // MARK: - Methods
    func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs {
        searchSongsCallCount += 1

        return searchSongsResult
    }

    func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song] {
        return []
    }
}
