//
//  AlbumDetailsItem.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation

/// Represents the album details rendered by the Album screen.
public struct AlbumDetailsItem: Equatable, Sendable {
    // MARK: - Properties
    public let albumID: Int
    public let title: String
    public let artistName: String
    public let artworkURL: URL?
    public let songs: [AlbumSongRowItem]

    // MARK: - Initializer
    public init(
        albumID: Int,
        title: String,
        artistName: String,
        artworkURL: URL?,
        songs: [AlbumSongRowItem]
    ) {
        self.albumID = albumID
        self.title = title
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.songs = songs
    }
}
