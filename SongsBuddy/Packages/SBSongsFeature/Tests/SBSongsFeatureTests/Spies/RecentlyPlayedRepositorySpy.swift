//
//  RecentlyPlayedRepositorySpy.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/15/26.
//

import Foundation
import SBDomain

@MainActor
final class RecentlyPlayedRepositorySpy: RecentlyPlayedRepositoryProtocol {
    // MARK: - Properties
    private(set) var savedSongs: [RecentlyPlayedSong] = []
    var deletedSongIDs: [Int] = []
    var fetchRecentlyPlayedResult: [RecentlyPlayedSong] = []

    // MARK: - Methods
    func save(
        song: RecentlyPlayedSong
    ) async throws {
        savedSongs.append(song)
    }

    func fetchRecentlyPlayed(
        limit: Int
    ) async throws -> [RecentlyPlayedSong] {
        return Array(fetchRecentlyPlayedResult.prefix(limit))
    }

    func delete(
        songID: Int
    ) async throws {
        deletedSongIDs.append(songID)
    }
}
