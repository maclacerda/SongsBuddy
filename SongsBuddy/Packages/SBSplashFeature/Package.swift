// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBSplashFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBSplashFeature",
            targets: ["SBSplashFeature"]
        )
    ],
    dependencies: [
        .package(path: "../SBDesignSystem"),
        .package(path: "../SBTestUtils"),

        /// External Dependencies
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.6")
    ],
    targets: [
        .target(
            name: "SBSplashFeature",
            dependencies: [
                .product(name: "SBDesignSystem", package: "SBDesignSystem")
            ]
        ),
        .testTarget(
            name: "SBSplashFeatureTests",
            dependencies: [
                "SBSplashFeature",

                .product(name: "SBTestUtils", package: "SBTestUtils"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
