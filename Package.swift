// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NovaMenu",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "NovaMenu", targets: ["NovaMenu"]),
    ],
    dependencies: [
        .package(url: "https://github.com/robb/Cartography", .branch("master")),
        .package(url: "https://github.com/netizen01/NovaLines.git", .branch("master")),
       
    ],
    targets: [
        .target(name: "NovaMenu", dependencies: ["Cartography", "NovaLines"])
    ]
)
