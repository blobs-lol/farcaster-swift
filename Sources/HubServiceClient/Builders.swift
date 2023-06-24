//
//  ClientBuilder.swift
//  farcaster-swift
//
//  Created by Michael Huang on 6/23/23.
//

import GRPC
import NIO

class HubServiceClientBuilder {
    private let cfg: GRPCChannelPool.Configuration
    private var callOptions: CallOptions
    private var interceptors: HubServiceClientInterceptorFactoryProtocol?

    init(cfg: GRPCChannelPool.Configuration,
         defaultCallOptions: CallOptions = CallOptions(),
         interceptors: HubServiceClientInterceptorFactoryProtocol? = nil
    ) {
        self.cfg = cfg
        self.callOptions = defaultCallOptions
        self.interceptors = interceptors
    }

    static func makeSecureClient(
        address: String,
        transportSecurity: GRPCChannelPool.Configuration.TransportSecurity,
        eventLoopGroup: EventLoopGroup
    ) throws -> HubServiceClientProtocol {
        let (host, port) = try getHostAndPort(address: address)
        return try HubServiceClientBuilder.init(cfg: .with(
            target: .host(host, port: port),
            transportSecurity: transportSecurity,
            eventLoopGroup: eventLoopGroup
        )).build()
    }

    static func makeInsecureClient(
        address: String,
        eventLoopGroup: EventLoopGroup
    ) throws -> HubServiceClientProtocol {
        let (host, port) = try getHostAndPort(address: address)
        return try HubServiceClientBuilder.init(cfg: .with(
            target: .host(host, port: port),
            transportSecurity: .plaintext,
            eventLoopGroup: eventLoopGroup
        )).build()
    }

    func withInterceptors(interceptors: HubServiceClientInterceptorFactoryProtocol) {
        self.interceptors = interceptors
    }

    func withCallOptions(callOptions: CallOptions) {
        self.callOptions = callOptions
    }

    func build() throws -> HubServiceClientProtocol {
        return HubServiceNIOClient(
            channel: try GRPCChannelPool.with(configuration: cfg),
            defaultCallOptions: callOptions,
            interceptors: interceptors
        )
    }
}

@available(macOS 10.15, *)
class HubServiceAsyncClientBuilder {
    private let cfg: GRPCChannelPool.Configuration
    private var callOptions: CallOptions
    private var interceptors: HubServiceClientInterceptorFactoryProtocol?

    init(cfg: GRPCChannelPool.Configuration,
         defaultCallOptions: CallOptions = CallOptions(),
         interceptors: HubServiceClientInterceptorFactoryProtocol? = nil
    ) {
        self.cfg = cfg
        self.callOptions = defaultCallOptions
        self.interceptors = interceptors
    }

    static func makeSecureClient(
        address: String,
        transportSecurity: GRPCChannelPool.Configuration.TransportSecurity,
        eventLoopGroup: EventLoopGroup
    ) throws -> HubServiceAsyncClientProtocol {
        let (host, port) = try getHostAndPort(address: address)
        return try HubServiceAsyncClientBuilder.init(cfg: .with(
            target: .host(host, port: port),
            transportSecurity: transportSecurity,
            eventLoopGroup: eventLoopGroup
        )).build()
    }

    static func makeInsecureClient(
        address: String,
        eventLoopGroup: EventLoopGroup
    ) throws -> HubServiceAsyncClientProtocol {
        let (host, port) = try getHostAndPort(address: address)
        return try HubServiceAsyncClientBuilder.init(cfg: .with(
            target: .host(host, port: port),
            transportSecurity: .plaintext,
            eventLoopGroup: eventLoopGroup
        )).build()
    }

    func withInterceptors(interceptors: HubServiceClientInterceptorFactoryProtocol) {
        self.interceptors = interceptors
    }

    func withCallOptions(callOptions: CallOptions) {
        self.callOptions = callOptions
    }

    func build() throws -> HubServiceAsyncClientProtocol {
        return HubServiceAsyncClient(
            channel: try GRPCChannelPool.with(configuration: cfg),
            defaultCallOptions: callOptions,
            interceptors: interceptors
        )
    }
}

private func getHostAndPort(address: String) throws -> (String, Int) {
    let parts = address.components(separatedBy: ":")
    // TODO(michael): validate address
    let host = parts[0]
    guard let port = Int(parts[1]) else {
        fatalError("port not found")
    }
    return (host, port)
}
