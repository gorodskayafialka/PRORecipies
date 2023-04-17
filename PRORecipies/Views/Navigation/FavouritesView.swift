//
//  FavouritesView.swift
//  PRORecipies
//
//  Created by DenchicEz on 11.04.2023.
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var uiViewModel: UIViewModel
    @StateObject var viewModel: FavouritesViewModel
    @Namespace var namespace

    @State private var contentHasScrolled = false

    var body: some View {
        ZStack {
            Color("Background")

            if viewModel.showDetail {
                detail
            }

            ScrollView {
                scrollDetection

                Rectangle()
                    .frame(width: 100, height: 200)
                    .opacity(0)


                Text("featured meals".uppercased())
                    .font(.body.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .offset(y: -100)
                list
                    .padding(.horizontal, 20)
                    .offset(y: -110)
            }
            .coordinateSpace(name: "scroll")
        }
        .onAppear {
            viewModel.fetchFavouritesMeals()
        }
        .onChange(of: viewModel.showDetail) { _ in
            withAnimation {
                uiViewModel.showTab.toggle()
                uiViewModel.showNav.toggle()
            }
        }
        .overlay(NavigationBar(title: NavigationTitle.home.rawValue, contentHasScrolled: $contentHasScrolled))
    }

    var list: some View {
        LazyVStack(spacing: 20) {
            meal.frame(height: 300)
        }
    }

    var detail: some View {
        ForEach(viewModel.favouriteMeals) { meal in
            if meal == viewModel.selectedMeal {
                MealView(namespace: namespace, meal: meal, showDetail: $viewModel.showDetail) {
                    viewModel.selectedMeal = nil
                }
            }
        }
    }

    var meal: some View {
        ForEach(viewModel.favouriteMeals) { meal in
            MealItem(namespace: namespace, meal: meal)
                .onTapGesture {
                    withAnimation(.openCard) {
                        viewModel.showDetail = true
                        viewModel.selectedMeal = meal
                    }
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: FavouritesViewModel(networkService: .mock))
            .environmentObject(UIViewModel())
    }
}