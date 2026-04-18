//
//  AppDependencies.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import Foundation
import SBDomain
import SwiftData

struct AppDependencies {
    // MARK: - Properties
    let modelContainer: ModelContainer
    let recentlyPlayedRepository: any RecentlyPlayedRepositoryProtocol

    // MARK: - Initializer
    init() {
        let schema = Schema([
            RecentlyPlayedSongEntity.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            let modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )

            let modelContext = ModelContext(
                modelContainer
            )

            self.modelContainer = modelContainer

            recentlyPlayedRepository = SwiftDataRecentlyPlayedRepository(
                modelContext: modelContext
            )
        } catch {
            preconditionFailure("Failed to create the model container")
        }
    }
}
