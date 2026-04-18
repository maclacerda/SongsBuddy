// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBAlbumFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBAlbumFeature",
            targets: ["SBAlbumFeature"]
        )
    ],
    dependencies: [
        .package(path: "../SBDesignSystem"),
        .package(path: "../SBDomain"),
        .package(path: "../SBTestUtils"),

        /// External Dependencies
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6")
    ],
    targets: [
        .target(
            name: "SBAlbumFeature",
            dependencies: [
                .product(name: "SBDesignSystem", package: "SBDesignSystem"),
                .product(name: "SBDomain", package: "SBDomain")
            ]
        ),
        .testTarget(
            name: "SBAlbumFeatureTests",
            dependencies: [
                "SBAlbumFeature",

                .product(name: "SBTestUtils", package: "SBTestUtils"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
