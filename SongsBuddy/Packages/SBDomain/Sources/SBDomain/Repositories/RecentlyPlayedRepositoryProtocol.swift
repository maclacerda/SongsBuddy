//
//  RecentlyPlayedRepositoryProtocol.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/14/26.
//

import Foundation

/// Defines the contract for storing and retrieving recently played songs.
public protocol RecentlyPlayedRepositoryProtocol: Sendable {
    /// Saves or updates a recently played song.
    func save(
        song: RecentlyPlayedSong
    ) async throws

    /// Fetches the most recently played songs.
    func fetchRecentlyPlayed(
        limit: Int
    ) async throws -> [RecentlyPlayedSong]

    /// Deletes a recently played song by identifier.
    func delete(
        songID: Int
    ) async throws
}
