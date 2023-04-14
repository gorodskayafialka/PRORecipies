//
//  PRORecipiesApp.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 11.04.2023.
//

import SwiftUI

@main
struct PRORecipiesApp: App {
	private var networkService: NetworkService

	init() {
		networkService = NetworkService(
            baseURL: URLFactory.urlString,
			dataFetcher: DataFetcher(
				fetch: URLSession(configuration: .default, delegate: nil, delegateQueue: .main).fetchRequest)
		)
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
