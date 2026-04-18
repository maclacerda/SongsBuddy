//
//  RecentlyPlayedSongEntity.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/14/26.
//

import Foundation
import SwiftData

@Model
final class RecentlyPlayedSongEntity {
    // MARK: - Properties
    @Attribute(.unique)
    var id: Int
    var title: String
    var artistName: String
    var artworkURLString: String?
    var previewURLString: String?
    var albumName: String?
    var albumID: Int?
    var playedAt: Date

    // MARK: - Initializer
    init(
        id: Int,
        title: String,
        artistName: String,
        artworkURLString: String?,
        previewURLString: String?,
        albumName: String?,
        albumID: Int?,
        playedAt: Date
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkURLString = artworkURLString
        self.previewURLString = previewURLString
        self.albumName = albumName
        self.albumID = albumID
        self.playedAt = playedAt
    }
}
