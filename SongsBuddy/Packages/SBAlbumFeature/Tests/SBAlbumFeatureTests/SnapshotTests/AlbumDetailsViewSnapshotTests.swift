//
//  AlbumDetailsViewSnapshotTests.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import SBAlbumFeature
import SwiftUI
import SBTestUtils
import Testing

@Suite("AlbumDetailsView Snapshot Tests")
@MainActor
struct AlbumDetailsViewSnapshotTests {
    @Test("renders album details view")
    func rendersAlbumDetailsView() async {
        let repository = MusicRepositorySpy()

        repository.fetchAlbumSongsResult = [
            .init(
                id: 1,
                trackName: "Pull Me Under",
                artistName: "Dream Theater",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Images and Words",
                albumID: 100
            ),
            .init(
                id: 2,
                trackName: "Another Day",
                artistName: "Dream Theater",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Images and Words",
                albumID: 100
            )
        ]

        let viewModel = AlbumDetailsViewModel(
            albumID: 100,
            albumTitle: "Images and Words",
            artistName: "Dream Theater",
            artworkURL: nil,
            repository: repository
        )

        await viewModel.loadAlbum()

        let view = NavigationStack {
            AlbumDetailsView(
                viewModel: viewModel
            )
        }

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark
        )
    }

    @Test("renders loading view")
    func rendersLoadingView() {
        let repository = NeverCompletingMusicRepositorySpy()

        let viewModel = AlbumDetailsViewModel(
            albumID: 100,
            albumTitle: "Images and Words",
            artistName: "Dream Theater",
            artworkURL: nil,
            repository: repository
        )

        let view = NavigationStack {
            AlbumDetailsView(
                viewModel: viewModel
            )
        }

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_loading"
        )
    }

    @Test("renders error view")
    func rendersErrorView() async {
        let repository = FailingMusicRepositorySpy()

        let viewModel = AlbumDetailsViewModel(
            albumID: 100,
            albumTitle: "Images and Words",
            artistName: "Dream Theater",
            artworkURL: nil,
            repository: repository
        )

        await viewModel.loadAlbum()

        let view = NavigationStack {
            AlbumDetailsView(
                viewModel: viewModel
            )
        }

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_error"
        )
    }
}
