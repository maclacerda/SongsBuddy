//
//  PlaybackContext.swift
//  SBDomain
//
//  Created by Marcos Ferreira on 4/17/26.
//

import Foundation

/// Describes the current playback queue and the selected item index.
public struct PlaybackContext: Equatable, Sendable {
    // MARK: - Properties
    public let items: [PlaybackQueueItem]
    public let currentIndex: Int

    // MARK: - Initializer
    public init(
        items: [PlaybackQueueItem],
        currentIndex: Int
    ) {
        self.items = items
        self.currentIndex = currentIndex
    }

    // MARK: - Methods
    public var currentItem: PlaybackQueueItem? {
        guard items.indices.contains(currentIndex) else {
            return nil
        }

        return items[currentIndex]
    }

    public var hasPrevious: Bool {
        return currentIndex > 0
    }

    public var hasNext: Bool {
        return currentIndex < items.count - 1
    }

    public func previousContext() -> PlaybackContext? {
        guard hasPrevious else {
            return nil
        }

        return PlaybackContext(
            items: items,
            currentIndex: currentIndex - 1
        )
    }

    public func nextContext() -> PlaybackContext? {
        guard hasNext else {
            return nil
        }

        return PlaybackContext(
            items: items,
            currentIndex: currentIndex + 1
        )
    }
}
