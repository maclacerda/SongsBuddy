//
//  SongRowViewSnapshotTests.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/16/26.
//

import SBDesignSystem
import SBSongsFeature
import SwiftUI
import SBTestUtils
import Testing

@Suite("SongRowView Snapshot Tests")
@MainActor
struct SongRowViewSnapshotTests {
    @Test("renders song row")
    func rendersSongRow() {
        let item = SongRowItem.fixture()

        let view = AnyView(
            VStack {
                Spacer()

                SongRowView(
                    item: item,
                    onTap: {},
                    onMoreTapped: {}
                )
                .background(SBColors.screenBackground)

                Spacer()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.white)
        )

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark,
            named: "dark_renders_song_row"
        )
    }
}
