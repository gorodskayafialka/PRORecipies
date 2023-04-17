//
//  SearchView.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct SearchView: View {
    @Namespace var namespace
    @StateObject var searchViewModel: SearchViewModel
    @State var searchText: String = ""
    @State var contentHasScrolled: Bool = false

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack {
                Rectangle()
                    .frame(width: 100, height: 70)
                    .opacity(0)

                ScrollView {
                    SearchBar(text: $searchText)
                        .offset(y: contentHasScrolled ? -100 : 20)
                        .padding(.top, 20)

                    scrollDetection

                    list
                }
            }
            .overlay(NavigationBar(title: NavigationTitle.search.rawValue, contentHasScrolled: $contentHasScrolled))
        }
        .onAppearedOnce {
            searchViewModel.fetchSearchedMeals()
        }
    }

    var list: some View {
        LazyVStack(spacing: 16) {
            ForEach(searchViewModel.meals) { meal in
                RowMeal(meal: meal)
                    .padding(.horizontal, 20)
                    .background(Color("Background"))
                    .onTapGesture {
                        searchViewModel.selectedMeal = meal
                    }
            }
            .fullScreenCover(item: $searchViewModel.selectedMeal) { meal in
                MealView(namespace: namespace, meal: meal, showDetail: .constant(false))
            }

            Rectangle()
                .fill(.opacity(0))
                .frame(height: 60)
        }
        .onChange(of: searchText) { _ in
            withAnimation {
                searchViewModel.fetchSearchedMeals(for: searchText)
            }
        }
    }

    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel(networkService: .mock))
    }
}
