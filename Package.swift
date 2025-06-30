// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KinoaPushSdk",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "KinoaPushSdk",
            targets: ["KinoaPushSdk"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "KinoaPushSdk",
            dependencies: [],
            path: "com.kinoa.ios.kinoapushsdk/Sources/KinoaPushSdk"),
        .testTarget(
            name: "KinoaPushSdkTests",
            dependencies: ["KinoaPushSdk"],
            path: "com.kinoa.ios.kinoapushsdk/Tests/KinoaPushSdkTests"),
    ]
)
