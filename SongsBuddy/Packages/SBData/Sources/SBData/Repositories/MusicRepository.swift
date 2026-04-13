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
        offset: Int,
        limit: Int
    ) async throws -> [Song] {
        let response = try await remoteDataSource.searchSongs(
            term: term,
            offset: offset,
            limit: limit
        )

        return response.compactMap {
            return SongDTOMapper.map($0)
        }
    }
}
