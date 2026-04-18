// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBSongDetailsFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBSongDetailsFeature",
            targets: ["SBSongDetailsFeature"]
        )
    ],
    dependencies: [
        .package(path: "../SBDesignSystem"),
        .package(path: "../SBDomain"),
        .package(path: "../SBAlbumFeature"),
        .package(path: "../SBData"),
        .package(path: "../SBTestUtils"),

        /// External Dependencies
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6")
    ],
    targets: [
        .target(
            name: "SBSongDetailsFeature",
            dependencies: [
                .product(name: "SBDesignSystem", package: "SBDesignSystem"),
                .product(name: "SBDomain", package: "SBDomain"),
                .product(name: "SBAlbumFeature", package: "SBAlbumFeature"),
                .product(name: "SBData", package: "SBData")
            ]
        ),
        .testTarget(
            name: "SBSongDetailsFeatureTests",
            dependencies: [
                "SBSongDetailsFeature",

                .product(name: "SBTestUtils", package: "SBTestUtils"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
