//
//  URLFactory.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 14.04.2023.
//

import Foundation

enum URLFactory {
    public static var applicationAPI: URL {
        URL(string: baseURL + "\(apiKey)/")!
    }

    private static let baseURL = "https://themealdb.com/api/json/v2/"
    private static let apiKey = "9973533"
}
