// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBDesignSystem",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBDesignSystem",
            targets: ["SBDesignSystem"]
        )
    ],
    targets: [
        .target(
            name: "SBDesignSystem",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "SBDesignSystemTests",
            dependencies: ["SBDesignSystem"]
        )
    ]
)
