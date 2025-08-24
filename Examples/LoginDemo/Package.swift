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
        .package(path: "../../")  // Assuming the root NestedSwiftUIA11y package is two levels up
    ],
    targets: [
        .executableTarget(
            name: "LoginDemo",
            dependencies: [
                .product(name: "NestedA11yIDs", package: "NestedSwiftUIA11y")  // Assuming "NestedA11yIDs" is product name of the main package
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
