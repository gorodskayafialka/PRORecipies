//
//  NetworkService+URLSession.swift
//  PRORecipies
//
//  Created by Kirill Aldonin on 16.04.2023.
//

import Foundation

extension NetworkService {
    static func makeUrlSessionedService() -> Self {
        let sessionFetcher = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: .main
        ).fetchRequest

        return Self(
            baseURL: URLFactory.applicationAPI,
            dataFetcher: DataFetcher(fetch: sessionFetcher)
        )
    }
}
