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
        .package(path: "../SBDesignSystem")
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
            dependencies: ["SBSplashFeature"]
        )
    ]
)
