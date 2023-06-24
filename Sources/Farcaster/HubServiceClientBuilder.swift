//
//  ClientBuilder.swift
//  farcaster-swift
//
//  Created by Michael Huang on 6/23/23.
//

import GRPC

class HubServiceClientBuilder {
    private let cfg: GRPCChannelPool.Configuration
    private let callOptions: CallOptions
    private let interceptors: HubServiceClientInterceptorFactoryProtocol?

    init(cfg: GRPCChannelPool.Configuration,
         defaultCallOptions: CallOptions = CallOptions(),
         interceptors: HubServiceClientInterceptorFactoryProtocol? = nil
    ) {
        self.cfg = cfg
        self.callOptions = defaultCallOptions
        self.interceptors = interceptors
    }

    @available(macOS 10.15, *)
    func buildAsyncClient() throws -> HubServiceAsyncClientProtocol {
        return HubServiceAsyncClient(
            channel: try GRPCChannelPool.with(configuration: cfg),
            defaultCallOptions: callOptions,
            interceptors: interceptors
        )
    }

    func buildClient() throws -> HubServiceClientProtocol {
        return HubServiceNIOClient(
            channel: try GRPCChannelPool.with(configuration: cfg),
            defaultCallOptions: callOptions,
            interceptors: interceptors
        )
    }
}
