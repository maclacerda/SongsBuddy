//
//  AlbumDetailsItem+fixture.swift
//  SBAlbumFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import Foundation
import SBAlbumFeature

extension AlbumDetailsItem {
    static func fixture(
        albumID: Int = 100,
        title: String = "Images and Words",
        artistName: String = "Dream Theater",
        artworkURL: URL? = nil,
        songs: [AlbumSongRowItem] = [
            AlbumSongRowItem(
                id: 1,
                title: "Pull Me Under",
                artistName: "Dream Theater",
                artworkURL: nil
            ),
            AlbumSongRowItem(
                id: 2,
                title: "Another Day",
                artistName: "Dream Theater",
                artworkURL: nil
            )
        ]
    ) -> AlbumDetailsItem {
        return AlbumDetailsItem(
            albumID: albumID,
            title: title,
            artistName: artistName,
            artworkURL: artworkURL,
            songs: songs
        )
    }
}
