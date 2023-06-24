//
//  ServiceClient.swift
//  farcaster-swift
//
//  Created by Michael Huang on 6/23/23.
//

import GRPC
import NIO

enum ValidationError: Error {
    case invalidAddress(address: String)
    case portNotFound
}

extension HubServiceNIOClient {
    public static func createSecure(
        address: String,
        eventLoopGroup: EventLoopGroup,
        transportSecurity: GRPCChannelPool.Configuration.TransportSecurity =
            .tls(GRPCTLSConfiguration.makeClientConfigurationBackedByNIOSSL())
    ) throws -> HubServiceNIOClient {
        let (host, port) = try getHostAndPort(address: address)
        return self.init(
            channel: try GRPCChannelPool.with(configuration: .with(
                target: ConnectionTarget.host(host, port: port),
                transportSecurity: transportSecurity,
                eventLoopGroup: eventLoopGroup)
            )
        )
    }

    public static func createInsecure(
        address: String,
        eventLoopGroup: EventLoopGroup
    ) throws -> HubServiceNIOClient {
        let (host, port) = try getHostAndPort(address: address)
        return self.init(
            channel: try GRPCChannelPool.with(configuration: .with(
                target: ConnectionTarget.host(host, port: port),
                transportSecurity: .plaintext,
                eventLoopGroup: eventLoopGroup)
            )
        )
    }
}

@available(macOS 10.15, *)
extension HubServiceAsyncClient {
    public static func createSecure(
        address: String,
        eventLoopGroup: EventLoopGroup,
        transportSecurity: GRPCChannelPool.Configuration.TransportSecurity =
            .tls(GRPCTLSConfiguration.makeClientConfigurationBackedByNIOSSL())
    ) throws -> HubServiceAsyncClientProtocol {
        let (host, port) = try getHostAndPort(address: address)
        return self.init(
            channel: try GRPCChannelPool.with(configuration: .with(
                target: ConnectionTarget.host(host, port: port),
                transportSecurity: transportSecurity,
                eventLoopGroup: eventLoopGroup)
            )
        )
    }

    public static func createInsecure(
        address: String,
        eventLoopGroup: EventLoopGroup
    ) throws -> HubServiceAsyncClientProtocol {
        let (host, port) = try getHostAndPort(address: address)
        return self.init(
            channel: try GRPCChannelPool.with(configuration: .with(
                target: ConnectionTarget.host(host, port: port),
                transportSecurity: .plaintext,
                eventLoopGroup: eventLoopGroup)
            )
        )
    }
}

private func getHostAndPort(address: String) throws -> (String, Int) {
    let parts = address.components(separatedBy: ":")
    if parts.count != 2 {
        throw ValidationError.invalidAddress(address: address)
    }
    let host = parts[0]
    guard let port = Int(parts[1]) else {
        throw ValidationError.portNotFound
    }
    return (host, port)
}
