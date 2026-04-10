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
        term: String
    ) async throws -> [Song] {
        let dtos = try await self.remoteDataSource.searchSongs(term: term)

        return dtos.compactMap { dto in
            return SongDTOMapper.map(dto)
        }
    }
}
