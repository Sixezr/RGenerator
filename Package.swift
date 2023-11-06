// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RGenerator",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .executable(
            name: "RGenerator",
            targets: [
                "RGenerator"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "RGenerator",
            dependencies: [
                "Config",
                "FileFinder",
                "Parser",
                "Converter",
                "Writer",
            ]
        ),
        .target(
            name: "Config",
            dependencies: []
        ),
        .target(
            name: "FileFinder",
            dependencies: []
        ),
        .target(
            name: "Converter",
            dependencies: []
        ),
        .target(
            name: "Parser",
            dependencies: []
        ),
        .target(
            name: "Writer",
            dependencies: [
                "Config",
            ]
        ),
    ]
)
