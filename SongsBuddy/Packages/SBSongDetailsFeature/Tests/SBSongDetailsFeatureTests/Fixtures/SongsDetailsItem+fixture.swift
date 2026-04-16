//
//  SongsDetailsItem+fixture.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBSongDetailsFeature

extension SongDetailsItem {
    static func fixture(
        title: String = "Believer",
        artistName: String = "Imagine Dragons",
        artworkURL: URL? = nil,
        albumName: String? = "Evolve",
        previewURL: URL? = nil,
        albumID: Int? = 123
    ) -> SongDetailsItem {
        return SongDetailsItem(
            title: title,
            artistName: artistName,
            artworkURL: artworkURL,
            albumName: albumName,
            previewURL: previewURL,
            albumID: albumID
        )
    }
}
