//
//  NeverCompletingMusicRepositorySpy.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

@MainActor
final class NeverCompletingMusicRepositorySpy: MusicRepositoryProtocol {
    func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs {
        while true {
            try? await Task.sleep(for: .seconds(1))
        }
    }

    func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song] {
        while true {
            try? await Task.sleep(for: .seconds(1))
        }
    }
}
