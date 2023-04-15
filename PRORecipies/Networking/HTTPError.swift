//
//  HTTPError.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 13.04.2023.
//

import Foundation

struct HTTPError: LocalizedError {
    var code: Int
    var url: URL?

    var errorDescription: String? {
        var result = "HTTP Error\nCode: \(code)"
        if let url {
            result += "\nFailing URL: \(url.absoluteString)"
        }
        return result
    }
}
