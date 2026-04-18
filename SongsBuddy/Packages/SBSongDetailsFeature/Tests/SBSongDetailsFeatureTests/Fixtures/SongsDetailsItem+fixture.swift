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
        title: String = "Pull Me Under",
        artistName: String = "Dream Theater",
        artworkURL: URL? = nil,
        albumName: String? = "Images and Words",
        previewURL: URL? = nil,
        albumID: Int? = 100
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
