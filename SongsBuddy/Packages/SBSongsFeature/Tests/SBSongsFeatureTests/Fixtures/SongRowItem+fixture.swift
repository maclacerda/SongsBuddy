//
//  SongRowItem+fixture.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBSongsFeature

extension SongRowItem {
    static func fixture(
        id: Int = 1,
        title: String = "Pull Me Under",
        artistName: String = "Dream Theater",
        artworkURL: URL? = nil,
        previewURL: URL? = nil,
        albumName: String? = "Images and Words",
        albumID: Int? = 100
    ) -> SongRowItem {
        return SongRowItem(
            id: id,
            title: title,
            artistName: artistName,
            artworkURL: artworkURL,
            previewURL: previewURL,
            albumName: albumName,
            albumID: albumID
        )
    }
}
