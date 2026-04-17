//
//  SnapshotRecentlyPlayedRepository.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

@MainActor
final class SnapshotRecentlyPlayedRepository: RecentlyPlayedRepositoryProtocol {
    // MARK: - Properties
    let recentlyPlayedSongs: [RecentlyPlayedSong]

    // MARK: - Initializer
    init(
        recentlyPlayedSongs: [RecentlyPlayedSong] = []
    ) {
        self.recentlyPlayedSongs = recentlyPlayedSongs
    }

    // MARK: - Methods
    func save(
        song: RecentlyPlayedSong
    ) async throws {}

    func fetchRecentlyPlayed(
        limit: Int
    ) async throws -> [RecentlyPlayedSong] {
        return Array(recentlyPlayedSongs.prefix(limit))
    }

    func delete(
        songID: Int
    ) async throws {}
}
