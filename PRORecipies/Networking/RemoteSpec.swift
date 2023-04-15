//
//  RemoteSpec.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 13.04.2023.
//

import Foundation

struct RequestParts {
    var path = ""
    var query: HTTPQuery = []
}

struct RemoteSpec<Args, DataType, Response> {
    enum Defaults {
        static var method: HTTPMethod { .get }
        static var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
        static var timeout: TimeInterval { 30 }
    }

    struct ArgsInterpreter {
        private var impl: (Args) async throws -> RequestParts

        init(impl: @escaping (Args) async throws -> RequestParts) {
            self.impl = impl
        }

        func callAsFunction(_ args: Args) async throws -> RequestParts {
            try await impl(args)
        }
    }
    var baseURL: URL
    var argsInterpreter: ArgsInterpreter
    var method = Defaults.method
    var cachePolicy = Defaults.cachePolicy
    var timeout = Defaults.timeout
    var decoder: (DataType) throws -> Response
    var fetcher: RequestFetcher<DataType>

    private func makeURL(path: String, query: HTTPQuery) throws -> URL {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )!

        components.queryItems = (components.queryItems ?? []) + query
        if components.queryItems?.isEmpty == true {
            components.queryItems = nil
        }

        guard let url = components.url else {
            throw InvalidURL(components: components)
        }

        return url
    }

    func performRequest(args: Args) async throws -> Response {
        let params = try await argsInterpreter(args)
        var request = URLRequest(
            url: try makeURL(path: params.path, query: params.query),
            cachePolicy: cachePolicy,
            timeoutInterval: timeout
        )
        request.httpMethod = method.rawValue

        return try decoder(await fetcher(request))
    }
}

extension RemoteSpec {
    init(
        baseURL: URL,
        path: String = "",
        query: HTTPQuery = [],
        method: HTTPMethod = Defaults.method,
        cachePolicy: URLRequest.CachePolicy = Defaults.cachePolicy,
        timeout: TimeInterval = Defaults.timeout,
        decoder: @escaping (DataType) throws -> Response,
        fetcher: RequestFetcher<DataType>
    ) {
        self.init(
            baseURL: baseURL,
            argsInterpreter: ArgsInterpreter { _ in
                RequestParts(path: path, query: query)
            },
            method: method,
            cachePolicy: cachePolicy,
            timeout: timeout,
            decoder: decoder,
            fetcher: fetcher
        )
    }
}

extension RemoteSpec where Response: Decodable, Args: ArgsQuery, Args: ArgsPath {
    init(
        baseURL: URL,
        method: HTTPMethod = Defaults.method,
        cachePolicy: URLRequest.CachePolicy = Defaults.cachePolicy,
        timeout: TimeInterval = Defaults.timeout,
        decoder: @escaping (DataType) throws -> Response,
        fetcher: RequestFetcher<DataType>
    ) {
        self.init(
            baseURL: baseURL,
            argsInterpreter: ArgsInterpreter {
                RequestParts(
                    path: $0.path,
                    query: $0.query
                )
            },
            method: method,
            cachePolicy: cachePolicy,
            timeout: timeout,
            decoder: decoder,
            fetcher: fetcher
        )
    }
}

extension RemoteSpec where Args == Void {
    func performRequest() async throws -> Response {
        try await performRequest(args: ())
    }
}

extension RemoteSpec where Response == Void {
    init(
        baseURL: URL,
        argsInterpreter: @escaping (Args) throws -> RequestParts,
        method: HTTPMethod = Defaults.method,
        cachePolicy: URLRequest.CachePolicy = Defaults.cachePolicy,
        timeout: TimeInterval = Defaults.timeout,
        fetcher: RequestFetcher<DataType>
    ) {
        self.init(
            baseURL: baseURL,
            argsInterpreter: ArgsInterpreter(impl: argsInterpreter),
            method: method,
            cachePolicy: cachePolicy,
            timeout: timeout,
            decoder: { _ in () },
            fetcher: fetcher
        )
    }
}

func decodeJSON<T: Decodable>(_ data: Data) throws -> T {
    try JSONDecoder().decode(T.self, from: data)
}

private struct InvalidURL: LocalizedError {
    let components: URLComponents

    var errorDescription: String? {
        "Failed to produce URL from \(components.debugDescription)"
    }
}
