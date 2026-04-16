//
//  SnapshotTestHelper.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/15/26.
//

import SnapshotTesting
import SwiftUI
import UIKit

enum SnapshotTestHelper {
    // MARK: - Properties
    static let deviceConfig: ViewImageConfig = .iPhone13Pro

    // MARK: - Methods
    @MainActor
    static func assertSnapshot<Value: View>(
        of view: Value,
        style: UIUserInterfaceStyle = .dark,
        named name: String? = nil,
        testName: String = #function,
        fileID: StaticString = #fileID,
        filePath: StaticString = #filePath,
        line: UInt = #line
    ) {
        let hostingController = UIHostingController(
            rootView: view
        )

        hostingController.overrideUserInterfaceStyle = style

        SnapshotTesting.assertSnapshot(
            of: hostingController,
            as: .image(on: Self.deviceConfig),
            named: name,
            fileID: fileID,
            file: filePath,
            testName: testName,
            line: line
        )
    }
}
