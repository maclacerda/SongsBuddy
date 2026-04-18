//
//  RecentlyPlayedSong+fixtureq.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

extension RecentlyPlayedSong {
    static func fixture(
        id: Int = 1,
        title: String = "Pull Me Under",
        artistName: String = "Dream Theater",
        artworkURL: URL? = nil,
        previewURL: URL? = nil,
        albumName: String? = "Images and Words",
        albumID: Int? = 100,
        playedAt: Date = Date()
    ) -> RecentlyPlayedSong {
        return RecentlyPlayedSong(
            id: id,
            title: title,
            artistName: artistName,
            artworkURL: artworkURL,
            previewURL: previewURL,
            albumName: albumName,
            albumID: albumID,
            playedAt: playedAt
        )
    }
}
