//
//  PaginatedSons.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/14/26.
//

import Foundation

/// Represents a paginated songs response used by the application.
public struct PaginatedSongs: Equatable, Sendable {
    // MARK: - Properties
    public let resultCount: Int
    public let items: [Song]

    // MARK: - Initializer
    public init(
        resultCount: Int,
        items: [Song]
    ) {
        self.resultCount = resultCount
        self.items = items
    }
}
