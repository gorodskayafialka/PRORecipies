//
//  NetworkService.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 14.04.2023.
//

import Foundation

struct NetworkService {
    var randomMeal: Remote<Void, Meals>
    var search: Remote<String, Meals>
    
    init(
        baseURL: URL,
        dataFetcher: DataFetcher
    ) {
        func makeRemoteSpec<Args, Response>(
            argsInterpreter: @escaping (Args) throws -> RequestParts,
            decoder: @escaping (Data) throws -> Response
        ) -> RemoteSpec<Args, Data, Response> {
            RemoteSpec<Args, Data, Response>(
                baseURL: baseURL,
                argsInterpreter: .init(impl: argsInterpreter),
                decoder: decoder,
                fetcher: dataFetcher
            )
        }
        
        func makeRemoteSpec<Args>(
            argsInterpreter: @escaping (Args) throws -> RequestParts
        ) -> RemoteSpec<Args, Data, Void> {
            makeRemoteSpec(argsInterpreter: argsInterpreter, decoder: { _ in () })
        }
        
        func makeRemoteSpec<Args, Response: Decodable>(
            argsInterpreter: @escaping (Args) throws -> RequestParts
        ) -> RemoteSpec<Args, Data, Response> {
            makeRemoteSpec(argsInterpreter: argsInterpreter, decoder: decodeJSON)
        }
        
        randomMeal = .from(makeRemoteSpec {  _ in
            RequestParts(path: "random.php")
        })
        
        search = .from(makeRemoteSpec {
            RequestParts(path: "search.php", query: queryItem(for: "s", value: $0))
        })
    }
}

private func queryItem(for name: String, value: String) -> [URLQueryItem] {
    [URLQueryItem(name: name, value: value)]
}
