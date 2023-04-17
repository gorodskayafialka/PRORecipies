//
//  TabBar.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct TabBar: View {
    private var tabItems: [TabItem]
    @State var selectedTab = Tab.home.tabItem
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    @EnvironmentObject var model: UIModel
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
        UITabBar.appearance().isHidden = true
        tabItems = Tab.allCases.map { $0.tabItem }
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .environmentObject(model)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[0])
                ExploreView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[1])
                FavoritesView(favouriteViewModel: FavouritesViewModel(networkService: networkService))
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[2])
                ListView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[3])
            }

            customTabs
                .ignoresSafeArea(.all, edges: .bottom)
                .offset(y: model.showTab ? 0 : 200)
                .onAppear {
                    selectedTab = tabItems.first ?? Tab.home.tabItem
                }
        }
    }

    var customTabs: some View {
        HStack(spacing: 0) {
            ForEach(tabItems, id: \.self) { tabItem in

                GeometryReader { reader in
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = tabItem
                            xAxis = reader.frame(in: .global).minX
                        }
                    }
                    ) {
                        Image(systemName: tabItem.icon)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(selectedTab == tabItem ? tabItem.color : Color.gray)
                            .padding(selectedTab == tabItem ? 15 : 0)
                            .background(Color("Shadow").opacity(selectedTab == tabItem ? 0.7 : 0), in: Circle())
                            .matchedGeometryEffect(id: tabItem, in: animation)
                            .offset(
                                x: selectedTab == tabItem ?
                                (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0,
                                y: selectedTab == tabItem ? -45 : 0)
                    }
                    .onAppear {
                        if tabItem == tabItems.first {
                            xAxis = reader.frame(in: .global).minX
                        }
                    }
                }
                .frame(width: 25, height: 30)

                if tabItem != tabItems.last {
                    Spacer(minLength: 0)
                }
            }
        }
        .frame(height: 40)
        .padding(.vertical, 10)
        .padding(.horizontal, 50)
        .background(.ultraThinMaterial)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(networkService: .mock)
            .environmentObject(UIModel())
    }
}
