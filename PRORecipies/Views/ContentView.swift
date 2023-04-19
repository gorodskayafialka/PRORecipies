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
        networkService = NetworkService.makeUrlSessionedService()
    }

    var body: some View {
        ZStack {
            TabBar(networkService: networkService)
                .environmentObject(UIViewModel())

            SplashScreen()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
