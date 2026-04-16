//
//  SnapshotTestHelper.swift
//  SBTestUtils
//
//  Created by Marcos Ferreira on 4/16/26.
//

import SnapshotTesting
import SwiftUI
import UIKit

/// A helper utility for performing snapshot tests on SwiftUI views.
///
/// `SnapshotTestHelper` centralizes configuration and execution of snapshot tests,
/// ensuring consistency across tests by applying a default device configuration
/// and interface style.
///
/// This helper wraps a SwiftUI `View` inside a `UIHostingController` and uses
/// the SnapshotTesting library to assert visual output.
public enum SnapshotTestHelper {
    /// The default device configuration used for snapshot testing.
    ///
    /// Currently set to `.iPhone13Pro`, but can be changed to simulate
    /// different devices during snapshot comparisons.
    public static let deviceConfig: ViewImageConfig = .iPhone13Pro

    /// Asserts a snapshot of a given SwiftUI view.
    ///
    /// This method renders the provided SwiftUI `View` inside a
    /// `UIHostingController`, applies the desired interface style,
    /// and compares the resulting image against a reference snapshot.
    ///
    /// - Parameters:
    ///   - view: The SwiftUI view to be tested.
    ///   - style: The user interface style to apply (`.light` or `.dark`). Default is `.light`.
    ///   - name: An optional name for the snapshot. Useful for differentiating multiple snapshots in the same test.
    ///   - testName: The name of the test function. Defaults to the calling function.
    ///   - fileID: The file identifier. Defaults to the calling file.
    ///   - filePath: The full file path. Defaults to the calling file path.
    ///   - line: The line number where the assertion is called. Defaults to the calling line.
    ///
    /// - Note:
    /// This method must be called from the main actor since it interacts with UIKit.
    ///
    /// - Important:
    /// Make sure reference snapshots are recorded before running assertions,
    /// otherwise tests may fail.
    @MainActor
    public static func assertSnapshot<Value: View>(
        of view: Value,
        style: UIUserInterfaceStyle = .light,
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