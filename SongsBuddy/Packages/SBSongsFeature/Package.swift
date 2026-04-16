// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBSongsFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBSongsFeature",
            targets: ["SBSongsFeature"]
        )
    ],
    dependencies: [
        .package(path: "../SBDesignSystem"),
        .package(path: "../SBDomain"),
        .package(path: "../SBSongDetailsFeature"),
        .package(path: "../SBTestUtils"),

        /// External Dependencies
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6")
    ],
    targets: [
        .target(
            name: "SBSongsFeature",
            dependencies: [
                .product(name: "SBDesignSystem", package: "SBDesignSystem"),
                .product(name: "SBAlbumFeature", package: "SBAlbumFeature"),
                .product(name: "SBData", package: "SBData"),
                .product(name: "SBDomain", package: "SBDomain"),
                .product(name: "SBSongDetailsFeature", package: "SBSongDetailsFeature")
            ]
        ),
        .testTarget(
            name: "SBSongsFeatureTests",
            dependencies: [
                "SBSongsFeature",

                .product(name: "SBTestUtils", package: "SBTestUtils"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
