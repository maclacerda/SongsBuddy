//
//  SongMoreOptionsSheetViewSnapshotTests.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import SBDesignSystem
import SwiftUI
import SBSongsFeature
import SBTestUtils
import Testing

@Suite("SongMoreOptionsSheetView Snapshot Tests")
@MainActor
struct SongMoreOptionsSheetViewSnapshotTests {
    @Test("renders more options sheet without remove option")
    func rendersMoreOptionsSheetWithoutRemoveOption() {
        let view = MoreOptionsSheetView(
            title: "Pull Me Under",
            artistName: "Dream Theater",
            onViewAlbum: {}
        )
        .frame(height: 192)
        .background(SBColors.screenBackground)

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_without_remove"
        )
    }

    @Test("renders more options sheet with remove option")
    func rendersMoreOptionsSheetWithRemoveOption() {
        let view = MoreOptionsSheetView(
            title: "Pull Me Under",
            artistName: "Dream Theater",
            onViewAlbum: {
            },
            showsRemoveFromRecents: true,
            onRemoveFromRecents: {}
        )
        .frame(height: 248)
        .background(SBColors.screenBackground)

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_with_remove"
        )
    }
}
