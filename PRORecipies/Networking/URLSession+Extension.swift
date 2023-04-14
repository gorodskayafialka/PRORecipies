//
//  URLSession+Extension.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 13.04.2023.
//

import Foundation

extension URLSession {
    func fetchRequest(_ request: URLRequest) async throws -> Data {
        let (fetchedData, response) = try await data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw HTTPError(
                code: httpResponse.statusCode,
                url: request.url
            )
        }
        return fetchedData
    }
}
