//
//  AlbumDetailsViewModel.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation
import Observation
import SBDomain

/// Manages album details loading and presentation.
@MainActor
@Observable
public final class AlbumDetailsViewModel {
    // MARK: - Properties
    public private(set) var item: AlbumDetailsItem?
    public private(set) var isLoading: Bool
    public private(set) var errorMessage: String?

    private let albumID: Int
    private let albumTitle: String
    private let artistName: String
    private let artworkURL: URL?
    private let repository: any MusicRepositoryProtocol

    // MARK: - Initializer
    public init(
        albumID: Int,
        albumTitle: String,
        artistName: String,
        artworkURL: URL?,
        repository: any MusicRepositoryProtocol
    ) {
        self.albumID = albumID
        self.albumTitle = albumTitle
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.repository = repository

        self.isLoading = false
        self.errorMessage = nil
        self.item = nil
    }

    // MARK: - Methods
    public func loadAlbum() async {
        guard item == nil else {
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await repository.fetchAlbumSongs(
                albumID: albumID
            )

            let songs = response.map { song in
                return AlbumSongRowItem(
                    id: song.id,
                    title: song.trackName,
                    artistName: song.artistName,
                    artworkURL: song.artworkURL,
                    previewURL: song.previewURL,
                    albumName: song.albumName,
                    albumID: song.albumID
                )
            }

            item = AlbumDetailsItem(
                albumID: albumID,
                title: albumTitle,
                artistName: artistName,
                artworkURL: artworkURL,
                songs: songs
            )
        } catch {
            errorMessage = "Unable to load album."
        }

        isLoading = false
    }
}
