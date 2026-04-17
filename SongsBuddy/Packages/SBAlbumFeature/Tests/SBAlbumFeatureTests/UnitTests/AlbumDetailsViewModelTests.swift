//
//  AlbumDetailsViewModelTests.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain
import SBAlbumFeature
import Testing

@Suite("AlbumDetailsViewModel Tests")
@MainActor
struct AlbumDetailsViewModelTests {
    @Test("load album maps songs into item")
    func loadAlbumMapsSongsIntoItem() async throws {
        let repository = MusicRepositorySpy()

        repository.fetchAlbumSongsResult = [
            Song(
                id: 1,
                trackName: "Pull Me Under",
                artistName: "Dream Theater",
                artworkURL: nil,
                previewURL: nil,
                albumName: "Images and Words",
                albumID: 100
            ),
            Song(
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

        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.item?.title == "Images and Words")
        #expect(viewModel.item?.songs.count == 2)
        #expect(viewModel.item?.songs.first?.title == "Pull Me Under")
    }

    @Test("load album sets error on failure")
    func loadAlbumSetsErrorOnFailure() async throws {
        let repository = FailingMusicRepositorySpy()

        let viewModel = AlbumDetailsViewModel(
            albumID: 100,
            albumTitle: "Images and Words",
            artistName: "Dream Theater",
            artworkURL: nil,
            repository: repository
        )

        await viewModel.loadAlbum()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.item == nil)
        #expect(viewModel.errorMessage == "Unable to load album.")
    }

    @Test("load album does not fetch again when item already exists")
    func loadAlbumDoesNotFetchAgainWhenItemAlreadyExists() async throws {
        let repository = MusicRepositorySpy()

        repository.fetchAlbumSongsResult = [
            Song(
                id: 1,
                trackName: "Pull Me Under",
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
        await viewModel.loadAlbum()

        #expect(repository.fetchAlbumSongsCallCount == 1)
    }
}
