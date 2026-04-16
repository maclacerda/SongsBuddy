// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBTestUtils",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBTestUtils",
            targets: ["SBTestUtils"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6")
    ],
    targets: [
        .target(
            name: "SBTestUtils",
            dependencies: [
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        ),
        .testTarget(
            name: "SBTestUtilsTests",
            dependencies: ["SBTestUtils"]
        )
    ]
)
