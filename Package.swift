// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tictactoe",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "tictactoe",
            targets: ["tictactoe"]),
    ],
    dependencies: [
        .package(url: "https://github.com/joshuaauerbachwatson/AuerbachLook.git", branch: "main"),
        .package(url: "https://github.com/joshuaauerbachwatson/unigame.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "tictactoe",
            dependencies: [
                .product(name: "AuerbachLook", package: "auerbachlook"),
                .product(name: "unigame", package: "unigame")
            ],
        )
    ]
)
