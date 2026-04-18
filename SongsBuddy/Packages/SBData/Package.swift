// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBData",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBData",
            targets: ["SBData"]
        )
    ],
    dependencies: [
        .package(path: "../SBCore"),
        .package(path: "../SBDomain")
    ],
    targets: [
        .target(
            name: "SBData",
            dependencies: [
                .product(name: "SBCore", package: "SBCore"),
                .product(name: "SBDomain", package: "SBDomain")
            ]
        ),
        .testTarget(
            name: "SBDataTests",
            dependencies: ["SBData"]
        )
    ]
)
