//
//  SplashViewSnapshotTests.swift
//  SBSplashFeature
//
//  Created by Marcos Ferreira on 4/17/26.
//

import SBSplashFeature
import SwiftUI
import SBTestUtils
import Testing

@Suite("SplashView Snapshot Tests")
@MainActor
struct SplashViewSnapshotTests {
    @Test("renders splash view")
    func rendersSplashView() {
        let view = SplashView(
            progress: 0.1
        )

        SnapshotTestHelper.assertSnapshot(
            of: view,
            style: .dark
        )
    }
}
