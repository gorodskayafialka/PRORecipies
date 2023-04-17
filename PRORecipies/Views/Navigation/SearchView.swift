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

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack {
                Text(NavigationTitle.search.rawValue)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .topLeading)
                    .padding(.horizontal, 20)
                    .padding(.top, 64)

                SearchBar(text: $searchText)

                ScrollView {
                    list
                }
            }
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
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel(networkService: .mock))
    }
}
