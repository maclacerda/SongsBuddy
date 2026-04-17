//
//  FailingSnapshotMusicRepository.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

@MainActor
final class FailingSnapshotMusicRepository: MusicRepositoryProtocol {
    struct DummyError: Error {}

    func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs {
        throw DummyError()
    }

    func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song] {
        throw DummyError()
    }
}
