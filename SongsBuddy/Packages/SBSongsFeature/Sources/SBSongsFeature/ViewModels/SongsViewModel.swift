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
    public private(set) var isLoadingNextPage: Bool = false

    private let repository: any MusicRepositoryProtocol
    private var searchTask: Task<Void, Never>?

    private let initialSearchTerm: String = "rock"
    private let remoteFetchLimit: Int = 200
    private let pageSize: Int = 20

    private var currentTerm: String = ""
    private var allItems: [SongRowItem] = []
    private var visibleItems: [SongRowItem] = []
    private var currentPage: Int = 0
    private var hasMoreResults: Bool = true
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
        guard case .idle = state else {
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

        loadNextPage()
    }

    private func startNewSearch(
        term: String
    ) async {
        currentSearchSessionID = UUID()
        currentTerm = term
        visibleItems = []
        allItems = []
        currentPage = 0
        hasMoreResults = true
        isLoadingNextPage = false
        lastPaginationTriggerItemID = nil

        state = .loading

        await fetchAllResults(
            searchSessionID: currentSearchSessionID
        )
    }

    private func loadNextPage() {
        guard hasMoreResults else {
            return
        }

        isLoadingNextPage = true

        let startIndex = currentPage * pageSize

        let endIndex = min(
            startIndex + pageSize,
            allItems.count
        )

        guard startIndex < endIndex else {
            hasMoreResults = false
            isLoadingNextPage = false

            return
        }

        let nextPageItems = Array(
            allItems[startIndex..<endIndex]
        )

        visibleItems.append(contentsOf: nextPageItems)
        currentPage += 1

        hasMoreResults = visibleItems.count < allItems.count
        lastPaginationTriggerItemID = nil

        isLoadingNextPage = false

        state = .content(items: visibleItems)
    }

    private func fetchAllResults(
        searchSessionID: UUID
    ) async {
        do {
            let response = try await repository.searchSongs(
                term: currentTerm,
                limit: remoteFetchLimit
            )

            guard searchSessionID == currentSearchSessionID else {
                return
            }

            let items = response.items.map { song in
                return SongRowItem(
                    id: song.id,
                    title: song.trackName,
                    artistName: song.artistName,
                    artworkURL: song.artworkURL,
                    previewURL: song.previewURL,
                    albumName: song.albumName,
                    albumID: song.albumID
                )
            }

            allItems = removeDuplicatedItems(from: items)

            visibleItems = []
            currentPage = 0

            hasMoreResults = !allItems.isEmpty
            lastPaginationTriggerItemID = nil

            loadNextPage()

            if visibleItems.isEmpty {
                self.state = .empty(searchTerm: currentTerm)

                return
            }

            state = .content(items: visibleItems)
        } catch {
            guard searchSessionID == currentSearchSessionID else {
                return
            }

            state = .error(message: "Something went wrong. Please try again.")
        }
    }

    private func shouldLoadNextPage(
        currentItemID: Int
    ) -> Bool {
        let thresholdIndex = max(
            visibleItems.count - 5,
            0
        )

        guard let currentIndex = visibleItems.firstIndex(where: { $0.id == currentItemID }) else {
            return false
        }

        return currentIndex >= thresholdIndex
    }

    private func removeDuplicatedItems(
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
