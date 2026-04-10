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
        .package(path: "../SBDomain")
    ],
    targets: [
        .target(
            name: "SBSongsFeature",
            dependencies: [
                .product(name: "SBDesignSystem", package: "SBDesignSystem"),
                .product(name: "SBDomain", package: "SBDomain")
            ]
        ),
        .testTarget(
            name: "SBSongsFeatureTests",
            dependencies: ["SBSongsFeature"]
        )
    ]
)
