//
//  ContentView.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 11.04.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    private var networkService: NetworkService
    
    init() {
        networkService = NetworkService(
            baseURL: URLFactory.applicationAPI,
            dataFetcher: DataFetcher(
                fetch: URLSession(configuration: .default, delegate: nil, delegateQueue: .main).fetchRequest)
        )
    }

    var body: some View {
        TabBar(networkService: networkService)
            .environmentObject(UIModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
