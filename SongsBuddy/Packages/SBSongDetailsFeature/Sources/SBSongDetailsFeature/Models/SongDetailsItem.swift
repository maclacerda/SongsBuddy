//
//  SongDetailsItem.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation

/// Represents the song details data rendered by the Player screen.
public struct SongDetailsItem: Equatable, Sendable {
    // MARK: - Properties
    public let title: String
    public let artistName: String
    public let artworkURL: URL?
    public let albumName: String?
    public let previewURL: URL?
    public let albumID: Int?

    // MARK: - Initializer
    public init(
        title: String,
        artistName: String,
        artworkURL: URL?,
        albumName: String?,
        previewURL: URL?,
        albumID: Int?
    ) {
        self.title = title
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.albumName = albumName
        self.previewURL = previewURL
        self.albumID = albumID
    }
}
