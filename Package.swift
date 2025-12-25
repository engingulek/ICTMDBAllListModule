//swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "ICTMDBAllListModule",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "ICTMDBAllListModule",
            targets: ["ICTMDBAllListModule"]
        ),
    ],
    dependencies: [
        
        
        
        .package(url: "https://github.com/engingulek/ICTMDBNetworkManagerKit", branch: "feature/create-modular-network-layer"),
        .package(url: "https://github.com/engingulek/ICTMDBViewKit", branch: "version/swiftui"),
        .package(url: "https://github.com/engingulek/ICTMDBModularProtocols", branch: "version/swiftui"),
        .package(url: "https://github.com/engingulek/ICTMDBNavigationManagerSwiftUI", branch: "master")
    ],
    targets: [
        .target(
            name: "ICTMDBAllListModule",
            dependencies: [
                .product(name: "ICTMDBNetworkManagerKit", package: "ICTMDBNetworkManagerKit"),
                .product(name: "ICTMDBViewKit", package: "ICTMDBViewKit"),
                .product(name: "ICTMDBModularProtocols", package: "ICTMDBModularProtocols"),
                .product(name: "ICTMDBNavigationManagerSwiftUI", package: "ICTMDBNavigationManagerSwiftUI")
                
            ],
            path: "ICTMDBAllListModule"
        )
    ]
)
