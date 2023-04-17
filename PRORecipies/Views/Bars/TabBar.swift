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
    @EnvironmentObject var uiViewModel: UIViewModel
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
        UITabBar.appearance().isHidden = true
        tabItems = Tab.allCases.map { $0.tabItem }
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                HomeView(homeViewModel: HomeViewModel(networkService: networkService))
                    .environmentObject(uiViewModel)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[0])
                ExploreView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[1])
                FavoritesView(favouritesViewModel: FavouritesViewModel(networkService: networkService))
                    .environmentObject(uiViewModel)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[2])
                ListView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(tabItems[3])
            }

            customTabs
                .ignoresSafeArea(.all, edges: .bottom)
                .offset(y: uiViewModel.showTab ? 0 : 200)
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
                    }) {
                        Image(systemName: tabItem.icon)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(selectedTab == tabItem ? tabItem.color : Color("tabbarItem"))
                            .padding(selectedTab == tabItem ? 15 : 0)
                            .background(Color("tabbarItem").opacity(selectedTab == tabItem ? 0.9 : 0), in: Circle())
                            .matchedGeometryEffect(id: tabItem, in: animation)
                            .offset(
                                x: selectedTab == tabItem ?
                                (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0,
                                y: selectedTab == tabItem ? -30 : 0)
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
        .background(Color("tabbar"))
        .background(
            Color("tabbar").clipShape(CustomCurveShape(xAxis: xAxis))
        )
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(networkService: .mock)
            .environmentObject(UIViewModel())
    }
}
