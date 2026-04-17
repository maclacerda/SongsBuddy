//
//  SnapshotMusicRepository.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

@MainActor
final class SnapshotMusicRepository: MusicRepositoryProtocol {
    // MARK: - Properties
    let paginatedSongs: PaginatedSongs

    // MARK: - Initializer
    init(
        paginatedSongs: PaginatedSongs
    ) {
        self.paginatedSongs = paginatedSongs
    }

    // MARK: - Methods
    func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs {
        return paginatedSongs
    }

    func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song] {
        return []
    }
}
