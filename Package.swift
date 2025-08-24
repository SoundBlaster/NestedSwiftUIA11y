// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NestedA11yIDs",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "NestedA11yIDs",
            targets: ["NestedA11yIDs"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NestedA11yIDs",
            dependencies: []),
        .testTarget(
            name: "NestedA11yIDsTests",
            dependencies: ["NestedA11yIDs"]),
    ]
)
