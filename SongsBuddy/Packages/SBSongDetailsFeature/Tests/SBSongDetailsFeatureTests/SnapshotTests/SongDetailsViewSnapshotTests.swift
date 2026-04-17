//
//  SongDetailsViewSnapshotTests.swift
//  SBSongDetailsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import SBSongDetailsFeature
import SBTestUtils
import SwiftUI
import Testing

@Suite("SongDetailsView Snapshot Tests")
@MainActor
struct SongDetailsViewSnapshotTests {
    @Test("renders song details view")
    func rendersSongDetailsView() {
        let audioPlayerService = AudioPlayerServiceSpy()

        let viewModel = SongDetailsViewModel(
            item: .fixture(),
            audioPlayerService: audioPlayerService
        )

        let view = NavigationStack {
            SongDetailsView(
                viewModel: viewModel
            )
        }

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark
        )
    }
}
