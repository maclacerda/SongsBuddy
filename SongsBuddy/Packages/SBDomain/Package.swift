// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SBDomain",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SBDomain",
            targets: ["SBDomain"]
        )
    ],
    targets: [
        .target(
            name: "SBDomain"
        ),
        .testTarget(
            name: "SBDomainTests",
            dependencies: ["SBDomain"]
        )
    ]
)
