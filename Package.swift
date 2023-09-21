// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TwitterCounter",
    products: [
        .library(
            name: "TwitterCounter",
            targets: ["TwitterCounter"]),
    ],
    targets: [
        .target(
            name: "TwitterCounter",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "TwitterCounterTests",
            dependencies: ["TwitterCounter"]),
    ]
)
