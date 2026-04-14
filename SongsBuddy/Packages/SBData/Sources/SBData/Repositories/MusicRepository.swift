//
//  MusicRepository.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import SBDomain

public struct MusicRepository: MusicRepositoryProtocol {
    // MARK: - Properties
    private let remoteDataSource: MusicRemoteDataSourceProtocol

    // MARK: - Initializer
    init(
        remoteDataSource: MusicRemoteDataSourceProtocol
    ) {
        self.remoteDataSource = remoteDataSource
    }

    public func searchSongs(
        term: String,
        limit: Int
    ) async throws -> PaginatedSongs {
        let response = try await remoteDataSource.searchSongs(
            term: term,
            limit: limit
        )

        let items = response.results.compactMap {
            return SongDTOMapper.map($0)
        }

        return .init(
            resultCount: response.resultCount,
            items: items
        )
    }

    public func fetchAlbumSongs(
        albumID: Int
    ) async throws -> [Song] {
        let response = try await remoteDataSource.fetchAlbumSongs(
            albumID: albumID
        )

        return response.compactMap {
            return SongDTOMapper.map($0)
        }
    }
}
