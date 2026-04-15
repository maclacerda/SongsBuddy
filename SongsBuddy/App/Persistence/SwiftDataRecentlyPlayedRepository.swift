//
//  SwiftDataRecentlyPlayedRepository.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/14/26.
//

import Foundation
import SBDomain
import SwiftData

@MainActor
final class SwiftDataRecentlyPlayedRepository: RecentlyPlayedRepositoryProtocol {
    // MARK: - Properties
    private let modelContext: ModelContext

    // MARK: - Initializer
    init(
        modelContext: ModelContext
    ) {
        self.modelContext = modelContext
    }

    // MARK: - Methods
    func save(
        song: RecentlyPlayedSong
    ) async throws {
        let songID = song.id

        let descriptor = FetchDescriptor<RecentlyPlayedSongEntity>(
            predicate: #Predicate<RecentlyPlayedSongEntity> { entity in
                entity.id == songID
            }
        )

        let existingEntity = try modelContext.fetch(descriptor).first

        if let existingEntity {
            existingEntity.title = song.title
            existingEntity.artistName = song.artistName
            existingEntity.artworkURLString = song.artworkURL?.absoluteString
            existingEntity.previewURLString = song.previewURL?.absoluteString
            existingEntity.albumName = song.albumName
            existingEntity.albumID = song.albumID
            existingEntity.playedAt = song.playedAt
        } else {
            let entity = RecentlyPlayedSongEntity(
                id: song.id,
                title: song.title,
                artistName: song.artistName,
                artworkURLString: song.artworkURL?.absoluteString,
                previewURLString: song.previewURL?.absoluteString,
                albumName: song.albumName,
                albumID: song.albumID,
                playedAt: song.playedAt
            )

            modelContext.insert(entity)
        }

        try modelContext.save()
    }

    func fetchRecentlyPlayed(
        limit: Int
    ) async throws -> [RecentlyPlayedSong] {
        var descriptor = FetchDescriptor<RecentlyPlayedSongEntity>(
            sortBy: [
                SortDescriptor(\.playedAt, order: .reverse)
            ]
        )

        descriptor.fetchLimit = limit

        let entities = try modelContext.fetch(descriptor)

        return entities.map { entity in
            return RecentlyPlayedSong(
                id: entity.id,
                title: entity.title,
                artistName: entity.artistName,
                artworkURL: entity.artworkURLString.flatMap(URL.init(string:)),
                previewURL: entity.previewURLString.flatMap(URL.init(string:)),
                albumName: entity.albumName,
                albumID: entity.albumID,
                playedAt: entity.playedAt
            )
        }
    }

    func delete(
        songID: Int
    ) async throws {
        let descriptor = FetchDescriptor<RecentlyPlayedSongEntity>(
            predicate: #Predicate<RecentlyPlayedSongEntity> { entity in
                entity.id == songID
            }
        )

        let entities = try modelContext.fetch(descriptor)

        for entity in entities {
            modelContext.delete(entity)
        }

        try modelContext.save()
    }
}
