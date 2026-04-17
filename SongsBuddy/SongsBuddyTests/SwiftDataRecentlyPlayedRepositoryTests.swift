//
//  SwiftDataRecentlyPlayedRepositoryTests.swift
//  SongsBuddyTests
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain
import SwiftData
import Testing

@testable import SongsBuddy

@Suite("SwiftDataRecentlyPlayedRepository Tests")
@MainActor
struct SwiftDataRecentlyPlayedRepositoryTests {
    @Test("save inserts and fetch returns item")
    func saveInsertsAndFetchReturnsItem() async throws {
        let repository = self.makeRepository()

        let song = RecentlyPlayedSong(
            id: 1,
            title: "Pull Me Under",
            artistName: "Dream Theater",
            artworkURL: nil,
            previewURL: nil,
            albumName: "Images and Words",
            albumID: 100,
            playedAt: Date()
        )

        try await repository.save(song: song)

        let items = try await repository.fetchRecentlyPlayed(limit: 10)

        #expect(items.count == 1)
        #expect(items.first?.title == "Pull Me Under")
    }

    @Test("save updates existing item with same id")
    func saveUpdatesExistingItemWithSameID() async throws {
        let repository = self.makeRepository()

        let initialDate = Date(timeIntervalSince1970: 100)
        let updatedDate = Date(timeIntervalSince1970: 200)

        try await repository.save(
            song: RecentlyPlayedSong(
                id: 1,
                title: "Old Title",
                artistName: "Dream Theater",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Old Album",
                albumID: 100,
                playedAt: initialDate
            )
        )

        try await repository.save(
            song: RecentlyPlayedSong(
                id: 1,
                title: "New Title",
                artistName: "Dream Theater",
                artworkURL: nil,
                previewURL: nil,
                albumName: "New Album",
                albumID: 100,
                playedAt: updatedDate
            )
        )

        let items = try await repository.fetchRecentlyPlayed(limit: 10)

        #expect(items.count == 1)
        #expect(items.first?.title == "New Title")
        #expect(items.first?.albumName == "New Album")
        #expect(items.first?.playedAt == updatedDate)
    }

    @Test("fetch returns items ordered by playedAt descending")
    func fetchReturnsItemsOrderedByPlayedAtDescending() async throws {
        let repository = self.makeRepository()

        try await repository.save(
            song: RecentlyPlayedSong(
                id: 1,
                title: "Older",
                artistName: "Artist",
                artworkURL: nil,
                previewURL: nil,
                albumName: nil,
                albumID: nil,
                playedAt: Date(timeIntervalSince1970: 100)
            )
        )

        try await repository.save(
            song: RecentlyPlayedSong(
                id: 2,
                title: "Newer",
                artistName: "Artist",
                artworkURL: nil,
                previewURL: nil,
                albumName: nil,
                albumID: nil,
                playedAt: Date(timeIntervalSince1970: 200)
            )
        )

        let items = try await repository.fetchRecentlyPlayed(limit: 10)

        #expect(items.count == 2)
        #expect(items.first?.title == "Newer")
        #expect(items.last?.title == "Older")
    }

    @Test("delete removes saved item")
    func deleteRemovesSavedItem() async throws {
        let repository = self.makeRepository()

        try await repository.save(
            song: RecentlyPlayedSong(
                id: 1,
                title: "Pull Me Under",
                artistName: "Dream Theater",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Images and Words",
                albumID: 100,
                playedAt: Date()
            )
        )

        try await repository.delete(songID: 1)

        let items = try await repository.fetchRecentlyPlayed(limit: 10)

        #expect(items.isEmpty)
    }

    private func makeRepository() -> SwiftDataRecentlyPlayedRepository {
        let schema = Schema([
            RecentlyPlayedSongEntity.self
        ])

        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        let container = try! ModelContainer(
            for: schema,
            configurations: [configuration]
        )

        let context = ModelContext(container)

        return SwiftDataRecentlyPlayedRepository(
            modelContext: context
        )
    }
}
