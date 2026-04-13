//
//  ItunesMusicRemoteDataSource.swift
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import SBCore

protocol MusicRemoteDataSourceProtocol: Sendable {
    func searchSongs(
        term: String,
        offset: Int,
        limit: Int
    ) async throws -> [SongDTO]
}

struct ITunesMusicRemoteDataSource: MusicRemoteDataSourceProtocol {
    // MARK: - Properties
    private let httpClient: HTTPClient

    // MARK: - Initializer
    init(
        httpClient: HTTPClient
    ) {
        self.httpClient = httpClient
    }

    func searchSongs(
        term: String,
        offset: Int,
        limit: Int
    ) async throws -> [SongDTO] {
        let request: SearchSongsRequest = .search(
            term: term,
            offset: offset,
            limit: limit
        )

        let response = try await httpClient.send(
            request,
            responseType: SongSearchResponseDTO.self
        )

        return response.results
    }
}
