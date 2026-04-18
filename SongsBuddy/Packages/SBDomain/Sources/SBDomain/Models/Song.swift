//
//  Song.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Represents a song displayed by the application.
public struct Song: Identifiable, Equatable, Sendable {
    // MARK: - Properties
    public let id: Int
    public let trackName: String
    public let artistName: String
    public let artworkURL: URL?
    public let previewURL: URL?
    public let albumName: String?
    public let albumID: Int?

    // MARK: - Initializer
    public init(
        id: Int,
        trackName: String,
        artistName: String,
        artworkURL: URL?,
        previewURL: URL?,
        albumName: String?,
        albumID: Int?
    ) {
        self.id = id
        self.trackName = trackName
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.previewURL = previewURL
        self.albumName = albumName
        self.albumID = albumID
    }
}
