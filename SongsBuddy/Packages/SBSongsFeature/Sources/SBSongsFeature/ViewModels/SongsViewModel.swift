//
//  SongsViewModel.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import Observation
import SBDomain

/// Manages the presentation state and search flow for the Songs screen.
@MainActor
@Observable
public final class SongsViewModel {
    // MARK: - Properties
    public var searchText: String
    public private(set) var state: SongsScreenState

    private let repository: any MusicRepositoryProtocol
    private var searchTask: Task<Void, Never>?

    private let initialSearchTerm: String = "rock"
    private let limit: Int = 20

    private var currentTerm: String = ""
    private var currentOffset: Int = 0
    private var hasMoreResults: Bool = true
    private var isLoadingNextPage: Bool = false
    private var items: [SongRowItem] = []
    private var lastPaginationTriggerItemID: Int?
    private var currentSearchSessionID: UUID = UUID()

    // MARK: - Initializer
    public init(
        repository: any MusicRepositoryProtocol
    ) {
        self.repository = repository
        self.searchText = ""
        self.state = .idle
    }

    // MARK: - Methods
    public func loadInitialSongs() async {
        guard case .idle = self.state else {
            return
        }

        await startNewSearch(
            term: initialSearchTerm
        )
    }

    public func scheduleSearch() {
        searchTask?.cancel()

        searchTask = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(350))

            guard !Task.isCancelled else {
                return
            }

            guard let self else {
                return
            }

            let trimmedSearchText = self.searchText.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            if trimmedSearchText.isEmpty {
                await self.startNewSearch(term: self.initialSearchTerm)

                return
            }

            await self.startNewSearch(term: trimmedSearchText)
        }
    }

    public func retry() async {
        let trimmedSearchText = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if trimmedSearchText.isEmpty {
            await startNewSearch(term: initialSearchTerm)

            return
        }

        await startNewSearch(
            term: trimmedSearchText
        )
    }

    public func loadNextPageIfneeded(
        currentItemID: Int
    ) async {
        guard !isLoadingNextPage else {
            return
        }

        guard hasMoreResults else {
            return
        }

        guard shouldLoadNextPage(
            currentItemID: currentItemID
        ) else {
            return
        }

        guard lastPaginationTriggerItemID != currentItemID else {
            return
        }

        lastPaginationTriggerItemID = currentItemID

        await loadNextPage()
    }

    private func startNewSearch(
        term: String
    ) async {
        currentSearchSessionID = UUID()
        currentTerm = term
        currentOffset = 0
        hasMoreResults = true
        isLoadingNextPage = false
        lastPaginationTriggerItemID = nil

        items = []

        state = .loading

        await fetchPage(
            resetResults: true,
            searchSessionID: currentSearchSessionID
        )
    }

    private func loadNextPage() async {
        guard hasMoreResults else {
            return
        }

        isLoadingNextPage = true

        await fetchPage(
            resetResults: false,
            searchSessionID: currentSearchSessionID
        )

        isLoadingNextPage = false
    }

    private func fetchPage(
        resetResults: Bool,
        searchSessionID: UUID
    ) async {
        do {
            guard searchSessionID == currentSearchSessionID else {
                return
            }

            let songs = try await repository.searchSongs(
                term: currentTerm,
                offset: currentOffset,
                limit: limit
            )

            let items = songs.map { song in
                return SongRowItem(
                    id: song.id,
                    title: song.trackName,
                    artistName: song.artistName,
                    artworkURL: song.artworkURL
                )
            }

            if resetResults {
                self.items = deDuplicatedItems(from: items)
            } else {
                self.items = deDuplicatedItems(
                    from: self.items + items
                )
            }

            currentOffset += items.count
            hasMoreResults = items.count == limit

            if items.isEmpty {
                self.state = .empty(searchTerm: currentTerm)

                return
            }

            state = .content(items: self.items)
        } catch {
            guard searchSessionID == currentSearchSessionID else {
                return
            }

            if items.isEmpty {
                state = .error(message: "Something went wrong. Please try again.")

                return
            }

            state = .content(items: items)
        }
    }

    private func shouldLoadNextPage(
        currentItemID: Int
    ) -> Bool {
        let thresholdIndex = max(
            items.count - 5,
            0
        )

        guard let currentIndex = items.firstIndex(where: { $0.id == currentItemID }) else {
            return false
        }

        return currentIndex >= thresholdIndex
    }

    private func deDuplicatedItems(
        from items: [SongRowItem]
    ) -> [SongRowItem] {
        var seenIDs: Set<Int> = []
        var deduplicatedItems: [SongRowItem] = []

        for item in items {
            let wasInserted = seenIDs.insert(item.id).inserted

            guard wasInserted else {
                continue
            }

            deduplicatedItems.append(item)
        }

        return deduplicatedItems
    }
}
