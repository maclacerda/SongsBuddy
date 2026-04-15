//
//  RecentlyPlayedSong.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/14/26.
//

import Foundation

/// Represents a recently played song stored locally.
public struct RecentlyPlayedSong: Identifiable, Equatable, Sendable {
    // MARK: - Properties
    public let id: Int
    public let title: String
    public let artistName: String
    public let artworkURL: URL?
    public let previewURL: URL?
    public let albumName: String?
    public let albumID: Int?
    public let playedAt: Date

    // MARK: - Initializer
    public init(
        id: Int,
        title: String,
        artistName: String,
        artworkURL: URL?,
        previewURL: URL?,
        albumName: String?,
        albumID: Int?,
        playedAt: Date
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.previewURL = previewURL
        self.albumName = albumName
        self.albumID = albumID
        self.playedAt = playedAt
    }
}
