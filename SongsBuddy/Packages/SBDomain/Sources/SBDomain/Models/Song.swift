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

    // MARK: - Initializer
    public init(
        id: Int,
        trackName: String,
        artistName: String,
        artworkURL: URL?
    ) {
        self.id = id
        self.trackName = trackName
        self.artistName = artistName
        self.artworkURL = artworkURL
    }
}
