//
//  PRORecipiesApp.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 11.04.2023.
//

import SwiftUI

@main
struct PRORecipiesApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
