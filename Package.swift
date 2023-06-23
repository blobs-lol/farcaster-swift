// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Farcaster",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Farcaster",
            targets: ["Farcaster"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.15.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Farcaster"),
        .testTarget(
            name: "FarcasterTests",
            dependencies: ["Farcaster"]),
    ]
)
