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
        .package(path: "../SBDomain")
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
            dependencies: ["SBAlbumFeature"]
        )
    ]
)
