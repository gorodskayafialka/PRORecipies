//
//  RequestFetcher.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 13.04.2023.
//

import Foundation

struct RequestFetcher<DataType> {
    var fetch: (URLRequest) async throws -> DataType
    
    func callAsFunction(_ request: URLRequest) async throws -> DataType {
        try await fetch(request)
    }
}
