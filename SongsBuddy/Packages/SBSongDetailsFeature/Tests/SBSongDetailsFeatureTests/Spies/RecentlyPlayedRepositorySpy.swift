//
//  RecentlyPlayedRepositorySpy.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/17/26.
//

import Foundation
import SBDomain
@testable import SBSongDetailsFeature

@MainActor
final class RecentlyPlayedRepositorySpy: RecentlyPlayedRepositoryProtocol {
    var savedSongs: [RecentlyPlayedSong] = []

    func save(
        song: RecentlyPlayedSong
    ) async throws {
        savedSongs.append(song)
    }

    func fetchRecentlyPlayed(
        limit: Int
    ) async throws -> [RecentlyPlayedSong] {
        return []
    }

    func delete(
        songID: Int
    ) async throws {}
}
