//
//  Remote.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 13.04.2023.
//

import Foundation

struct Remote<Args, Response>: CustomDebugStringConvertible {
    private var request: (Args) async throws -> Response
    var debugDescription: String

    func callAsFunction(_ args: Args) async throws -> Response {
        try await request(args)
    }
}

extension Remote {
    static func from<DataType>(_ specs: RemoteSpec<Args, DataType, Response>) -> Self {
        Remote(request: specs.performRequest, debugDescription: String(describing: specs))
    }
}

extension Remote where Args == Void {
    func callAsFunction() async throws -> Response {
        try await callAsFunction(())
    }
}

extension Remote {
    static func mock(delay: TimeInterval = 0, _ response: Response) -> Self {
        Remote(request: { _ in
            try? await Task.sleep(nanoseconds: UInt64(max(delay, 0) * 1_000_000_000))
            return response
        }, debugDescription: "mock")
    }

    static func mock(delay: TimeInterval = 0, _ fetch: @escaping (Args) async throws -> Response) -> Self {
      Remote(request: {
        try? await Task.sleep(nanoseconds: UInt64(max(delay, 0) * 1_000_000_000))
        return try await fetch($0)
      }, debugDescription: "mock")
    }
}
