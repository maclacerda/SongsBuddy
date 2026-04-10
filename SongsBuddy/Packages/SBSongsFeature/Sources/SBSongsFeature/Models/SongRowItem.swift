//
//  SongRowItem.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Represents a song item displayed in the Songs list UI.
public struct SongRowItem: Identifiable, Equatable, Sendable {
    /// Unique identifier of the song row.
    public let id: Int

    /// Song title displayed in the primary label.
    public let title: String

    /// Artist name displayed in the secondary label.
    public let artistName: String

    /// Artwork URL string used during the mock phase.
    public let artworkURLString: String?

    // MARK: - Initializer
    public init(
        id: Int,
        title: String,
        artistName: String,
        artworkURLString: String?
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkURLString = artworkURLString
    }
}
