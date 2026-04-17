//
//  SongsViewSnapshotTests.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import SBDomain
import SBSongsFeature
import SwiftUI
import SBTestUtils
import Testing

@Suite("SongsView Snapshot Tests")
@MainActor
struct SongsViewSnapshotTests {
    @Test("renders loading state")
    func rendersLoadingState() {
        let repository = SnapshotMusicRepository(
            paginatedSongs: PaginatedSongs(
                resultCount: 0,
                items: []
            )
        )

        let recentlyPlayedRepository = SnapshotRecentlyPlayedRepository()

        let viewModel = SongsViewModel(
            repository: repository,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        let view = SongsView(
            viewModel: viewModel,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_loading"
        )
    }

    @Test("renders content state")
    func rendersContentState() async {
        let repository = SnapshotMusicRepository(
            paginatedSongs: PaginatedSongs(
                resultCount: 3,
                items: [
                    .fixture(id: 1, trackName: "Pull Me Under"),
                    .fixture(id: 2, trackName: "Another Day"),
                    .fixture(id: 3, trackName: "Take the Time")
                ]
            )
        )

        let recentlyPlayedRepository = SnapshotRecentlyPlayedRepository(
            recentlyPlayedSongs: [
                .fixture(id: 99, title: "Recently Played Song")
            ]
        )

        let viewModel = SongsViewModel(
            repository: repository,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        await viewModel.refreshRecentlyPlayed()
        await viewModel.loadInitialSongs()

        let view = SongsView(
            viewModel: viewModel,
            recentlyPlayedRepository: recentlyPlayedRepository
        )

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_content"
        )
    }
}
