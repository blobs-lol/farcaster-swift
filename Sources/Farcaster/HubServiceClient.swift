// The Swift Programming Language
// https://docs.swift.org/swift-book

extension HubServiceAsyncClientProtocol {
    init (cfg: GRPCChannelPool.Configuration) {
        return HubServiceAsyncClient(cfg: cfg)
    }
}
