// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LoginDemo",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .executable(
            name: "LoginDemo",
            targets: ["LoginDemo"]
        )
    ],
    dependencies: [
        .package(name: "NestedSwiftUIA11y", path: "../../")
    ],
    targets: [
        .executableTarget(
            name: "LoginDemo",
            dependencies: [
                .product(name: "NestedA11yIDs", package: "NestedSwiftUIA11y")
            ],
            path: ".",
            exclude: ["LoginSceneUITests.swift"],
            sources: ["LoginScene.swift", "LoginDemoApp.swift"],
            swiftSettings: [
                .define("SWIFTUI_ENABLED")
            ]
        )
    ]
)
