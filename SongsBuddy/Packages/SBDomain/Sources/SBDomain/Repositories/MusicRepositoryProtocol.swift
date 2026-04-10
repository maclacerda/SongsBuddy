//
//  MusicRepositoryProtocol.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Defines the repository contract for music-related operations.
public protocol MusicRepositoryProtocol: Sendable {
    /// Searches songs by a given search term.
    func searchSongs(
        term: String
    ) async throws -> [Song]
}
