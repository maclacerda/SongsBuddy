//
//  SongsScreenState.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation

/// Defines the visible UI states for the Songs screen.
public enum SongsScreenState: Equatable, Sendable {
    /// Initial state before content is loaded.
    case idle

    /// Loading state while content is being prepared.
    case loading

    /// Content state with filtered items.
    case content(items: [SongRowItem])

    /// Empty state for an active search query with no results.
    case empty(searchTerm: String)
}
