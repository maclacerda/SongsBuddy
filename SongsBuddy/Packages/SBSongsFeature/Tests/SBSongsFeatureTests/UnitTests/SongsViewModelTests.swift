//
//  SongsViewModelTests.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/15/26.
//

import Foundation
import SBDomain
import SBSongsFeature
import Testing

@Suite("SongsViewModel Tests")
@MainActor
struct SongsViewModelTests {
    @Test("loadInitialSongs loads first content page")
    func loadInitialSongsLoadsFirstPage() async throws {
        let repository = MusicRepositorySpy()
        let recentlyPlayedRepository = RecentlyPlayedRepositorySpy()

        repository.searchSongsResult = PaginatedSongs(
            resultCount: 3,
            items: [
                .init(
                    id: 1,
                    trackName: "Song 1",
                    artistName: "Artist 1",
                    artworkURL: nil,
                    previewURL: nil,
                    albumName: "Album 1",
                    albumID: 101
                ),
                .init(
                    id: 2,
                    trackName: "Song 2",
                    artistName: "Artist 2",
                    artworkURL: nil,
                    previewURL: nil,
                    albumName: "Album 2",
                    albumID: 102
                ),
                .init(
                    id: 3,
                    trackName: "Song 3",
                    artistName: "Artist 3",
                    artworkURL: nil,
                    previewURL: nil,
                    albumName: "Album 3",
                    albumID: 103
                )
            ]
        )

        let viewModel = SongsViewModel(
            repository: repository,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        await viewModel.loadInitialSongs()

        guard case let .content(items) = viewModel.state else {
            Issue.record("Expected content state after initial load")
            return
        }

        #expect(items.count == 3)
        #expect(items.first?.title == "Song 1")
        #expect(repository.searchSongsCallCount == 1)
    }

    @Test("refreshRecentlyPlayed maps persisted songs")
    func refreshRecentlyPlayedMapsPersistedSongs() async throws {
        let repository = MusicRepositorySpy()
        let recentlyPlayedRepository = RecentlyPlayedRepositorySpy()

        recentlyPlayedRepository.fetchRecentlyPlayedResult = [
            .init(
                id: 1,
                title: "Recent 1",
                artistName: "Artist A",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Album A",
                albumID: 201,
                playedAt: Date()
            ),
            .init(
                id: 2,
                title: "Recemt 2",
                artistName: "Artist B",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Album B",
                albumID: 202,
                playedAt: Date()
            )
        ]

        let viewModel = SongsViewModel(
            repository: repository,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        await viewModel.refreshRecentlyPlayed()

        #expect(viewModel.recentlyPlayedItems.count == 2)
        #expect(viewModel.recentlyPlayedItems.first?.title == "Recent 1")
    }

    @Test("markAsRecentlyPlayed saves and refreshes recents")
    func markAsRecentlyPlayedSavesAndRefreshesRecents() async throws {
        let repository = MusicRepositorySpy()
        let recentlyPlayedRepository = RecentlyPlayedRepositorySpy()

        recentlyPlayedRepository.fetchRecentlyPlayedResult = [
            .init(
                id: 1,
                title: "Saved Song",
                artistName: "Artist",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Album",
                albumID: 999,
                playedAt: Date()
            )
        ]

        let viewModel = SongsViewModel(
            repository: repository,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        let item = SongRowItem(
            id: 1,
            title: "Saved Song",
            artistName: "Artist",
            artworkURL: nil,
            previewURL: nil,
            albumName: "Album",
            albumID: 999
        )

        await viewModel.markAsRecentlyPlayed(item: item)

        #expect(recentlyPlayedRepository.savedSongs.count == 1)
        #expect(viewModel.recentlyPlayedItems.count == 1)
        #expect(viewModel.recentlyPlayedItems.first?.title == "Saved Song")
    }
}
