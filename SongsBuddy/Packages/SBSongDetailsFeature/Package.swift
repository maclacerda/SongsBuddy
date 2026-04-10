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
        .package(path: "../SBDomain")
    ],
    targets: [
        .target(
            name: "SBSongDetailsFeature",
            dependencies: [
                .product(name: "SBDesignSystem", package: "SBDesignSystem"),
                .product(name: "SBDomain", package: "SBDomain")
            ]
        ),
        .testTarget(
            name: "SBSongDetailsFeatureTests",
            dependencies: ["SBSongDetailsFeature"]
        )
    ]
)
