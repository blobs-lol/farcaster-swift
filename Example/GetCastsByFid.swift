//
//  GetCastsByFid.swift
//  
//
//  Created by Michael Huang on 6/23/23.
//

import Farcaster
import GRPC
import NIOPosix

@available(macOS 10.15, *)
@main
struct GetCastsByFid {
  static func main() async throws {
      // Setup an `EventLoopGroup` for the connection to run on.
      //
      // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
      let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

      // Make sure the group is shutdown when we're done with it.
      defer {
        try? group.syncShutdownGracefully()
      }

      let client = try HubServiceAsyncClient.createSecure(
        address: "nemes.farcaster.xyz:2283",
        eventLoopGroup: group
      )

      // Close the connection when we're done with it.
      defer {
        try? client.channel.close().wait()
      }

      do {
        let res = try await client.getCastsByFid(FidRequest.with { req in
            req.fid = 2
            req.pageSize = 10
            req.reverse = true
        })
        print(try res.jsonString())
      } catch {
        print("getCast failed: \(error)")
      }
  }
}
