//
//  Song+fixture.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBDomain

extension Song {
    static func fixture(
        id: Int = 1,
        trackName: String = "Pull Me Under",
        artistName: String = "Dream Theater",
        artworkURL: URL? = nil,
        previewURL: URL? = nil,
        albumName: String? = "Images and Words",
        albumID: Int? = 100
    ) -> Song {
        return Song(
            id: id,
            trackName: trackName,
            artistName: artistName,
            artworkURL: artworkURL,
            previewURL: previewURL,
            albumName: albumName,
            albumID: albumID
        )
    }
}
