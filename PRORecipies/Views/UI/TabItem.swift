//
//  TabItem.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct TabItem: Identifiable, Hashable, Equatable {
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
    var selection: Tab
}

enum Tab: String, Equatable {
    case home = "Home"
    case explore = "Explore"
    case favorites = "Favorites"
    case list = "List"
}

enum NavigationTitle: String {
    case home = "PRORecipes"
    case explore = "Explore"
    case favorites = "Favorites"
    case list = "List"
}

extension Tab {
    var tabItem: TabItem {
        TabItem(name: name, icon: icon.rawValue, color: color, selection: selection)
    }

    private var name: String {
        self.rawValue
    }

    private var icon: Icons {
        switch self {
        case .home:
            return Icons.home
        case .explore:
            return Icons.magnifyingglass
        case .favorites:
            return Icons.heart
        case .list:
            return Icons.list
        }
    }

    private var color: Color {
        Color.yellow
    }

    private var selection: Tab {
        self
    }
}

extension Tab: CaseIterable {

}
