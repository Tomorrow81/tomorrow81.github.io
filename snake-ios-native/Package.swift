// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SnakeNative",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SnakeEngine",
            targets: ["SnakeEngine"]
        )
    ],
    targets: [
        .target(
            name: "SnakeEngine"
        ),
        .testTarget(
            name: "SnakeEngineTests",
            dependencies: ["SnakeEngine"]
        )
    ]
)
