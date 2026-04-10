//
//  SongDTOMapper.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import SBDomain

enum SongDTOMapper {
    static func map(
        _ dto: SongDTO
    ) -> Song? {
        guard
            let id = dto.trackId,
            let trackName = dto.trackName,
            let artistName = dto.artistName
        else {
            return nil
        }

        let artworkURL = dto.artworkUrl100.flatMap(
            URL.init(string:)
        )

        return Song(
            id: id,
            trackName: trackName,
            artistName: artistName,
            artworkURL: artworkURL
        )
    }
}
