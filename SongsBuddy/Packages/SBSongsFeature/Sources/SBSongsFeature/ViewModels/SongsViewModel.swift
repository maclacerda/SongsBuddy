//
//  SongsViewModel.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import Observation

/// Manages the presentation state and search filtering for the Songs screen.
@Observable
public final class SongsViewModel {
    /// Search text bound to the native SwiftUI search field.
    public var searchText: String

    /// Current UI state rendered by the Songs screen.
    public private(set) var state: SongsScreenState

    private let allItems: [SongRowItem]

    // MARK: - Initializer
    public init() {
        self.searchText = ""
        self.allItems = Self.mockItems
        self.state = .idle
        self.loadInitialContent()
    }

    /// Loads the initial content for the screen.
    public func loadInitialContent() {
        return self.state = .content(items: self.allItems)
    }

    /// Updates the visible content according to the current search text.
    public func updateSearch() {
        let trimmedSearchText = self.searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedSearchText.isEmpty else {
            return self.state = .content(items: self.allItems)
        }

        let filteredItems = self.allItems.filter { item in
            let titleMatches = item.title.localizedCaseInsensitiveContains(trimmedSearchText)
            let artistMatches = item.artistName.localizedCaseInsensitiveContains(trimmedSearchText)

            return titleMatches || artistMatches
        }

        guard !filteredItems.isEmpty else {
            return self.state = .empty(searchTerm: trimmedSearchText)
        }

        return self.state = .content(items: filteredItems)
    }
}

private extension SongsViewModel {
    /// Mock items used to bootstrap the Songs screen before API integration.
    static var mockItems: [SongRowItem] {
        return [
            SongRowItem(
                id: 1,
                title: "Purple Rain",
                artistName: "Prince",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 2,
                title: "Power Of Equality",
                artistName: "Red Hot Chili Peppers",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 3,
                title: "Something",
                artistName: "The Beatles",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 4,
                title: "Like A Virgin",
                artistName: "Madonna",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 5,
                title: "Get Lucky",
                artistName: "Daft Punk feat. Pharrell Williams",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 6,
                title: "Billie Jean",
                artistName: "Michael Jackson",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 7,
                title: "Imagine",
                artistName: "John Lennon",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 8,
                title: "Wonderwall",
                artistName: "Oasis",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 9,
                title: "Hotel California",
                artistName: "Eagles",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 10,
                title: "Bohemian Rhapsody",
                artistName: "Queen",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 11,
                title: "Smells Like Teen Spirit",
                artistName: "Nirvana",
                artworkURLString: nil
            ),
            SongRowItem(
                id: 12,
                title: "Losing My Religion",
                artistName: "R.E.M.",
                artworkURLString: nil
            )
        ]
    }
}
