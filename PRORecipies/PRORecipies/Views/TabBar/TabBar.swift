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

    init() {
        UITabBar.appearance().isHidden = true
        tabItems = Tab.allCases.map { $0.tabItem }
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(Tab.home.rawValue)
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(Tab.explore.rawValue)
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(Tab.favorites.rawValue)
                Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(Tab.list.rawValue)
            }

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
                                .foregroundColor(selectedTab == tabItem ? Color.blue : Color.gray)
                                .padding(selectedTab == tabItem ? 15 : 0)
                                .background(Color.white.opacity(selectedTab == tabItem ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: tabItem, in: animation)
                                .offset(x: selectedTab == tabItem ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == tabItem ? -45 : 0)
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
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            selectedTab = tabItems.first ?? Tab.home.tabItem
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
