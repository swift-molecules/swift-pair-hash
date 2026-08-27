// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-pair-hash",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Pair Hash",
            targets: ["Pair Hash"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-pair.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Pair Hash",
            dependencies: [
                .product(name: "Pair", package: "swift-pair"),
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .testTarget(
            name: "Pair Hash Tests",
            dependencies: [
                "Pair Hash",
                .product(name: "Pair", package: "swift-pair"),
                .product(name: "Hash", package: "swift-hash"),
            ],
            path: "Tests/Pair Hash Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
