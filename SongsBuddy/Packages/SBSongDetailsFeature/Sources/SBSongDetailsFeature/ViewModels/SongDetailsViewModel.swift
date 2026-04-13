//
//  SongDetailsViewModel.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/13/26.
//

import Foundation
import Observation

/// Manages the Player screen presentation data.
@Observable
public final class SongDetailsViewModel {
    // MARK: - Properties
    public let item: SongDetailsItem

    // MARK: - Initializer
    public init(
        item: SongDetailsItem
    ) {
        self.item = item
    }
}
