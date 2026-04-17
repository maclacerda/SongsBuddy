//
//  AlbumSongRowItem.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation

/// Represents a song row displayed on the Album screen.
public struct AlbumSongRowItem: Identifiable, Equatable, Sendable, Hashable {
    // MARK: - Properties
    public let id: Int
    public let title: String
    public let artistName: String
    public let artworkURL: URL?
    public let previewURL: URL?
    public let albumName: String?
    public let albumID: Int?

    // MARK: - Initializer
    public init(
        id: Int,
        title: String,
        artistName: String,
        artworkURL: URL?,
        previewURL: URL?,
        albumName: String?,
        albumID: Int?
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.previewURL = previewURL
        self.albumName = albumName
        self.albumID = albumID
    }
}
