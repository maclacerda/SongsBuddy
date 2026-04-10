// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBCore",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBCore",
            targets: ["SBCore"]
        )
    ],
    targets: [
        .target(
            name: "SBCore"
        ),
        .testTarget(
            name: "SBCoreTests",
            dependencies: ["SBCore"]
        )
    ]
)
