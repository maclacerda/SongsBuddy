//
//  SongRowItem.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Represents a song item displayed in the Songs list UI.
public struct SongRowItem: Identifiable, Equatable, Sendable {
    // MARK: - Properties
    public let id: Int
    public let title: String
    public let artistName: String
    public let artworkURL: URL?

    // MARK: - Initializer
    public init(
        id: Int,
        title: String,
        artistName: String,
        artworkURL: URL?
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkURL = artworkURL
    }
}
