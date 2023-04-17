//
//  FavouritesView.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var uiViewModel: UIViewModel
    @StateObject var favouritesViewModel: FavouritesViewModel
    @Namespace var namespace

    @State private var contentHasScrolled = false


    var body: some View {
        ZStack {
            Color("Background")

            if favouritesViewModel.showDetail {
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
        .onAppear{
            favouritesViewModel.fetchFavouritesMeals()
        }
        .onChange(of: favouritesViewModel.showDetail) { _ in
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
        ForEach(favouritesViewModel.favouriteMeals) { meal in
            if meal.id == favouritesViewModel.selectedMeal {
                MealView(namespace: namespace, meal: meal, showDetail: $favouritesViewModel.showDetail) {
                    favouritesViewModel.selectedMeal = Meal.notFoundId
                }
            }
        }
    }

    var meal: some View {
        ForEach(favouritesViewModel.favouriteMeals) { meal in
            MealItem(namespace: namespace, meal: meal, selectedMeal: $favouritesViewModel.selectedMeal, showDetail: $favouritesViewModel.showDetail)
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
        FavoritesView(favouritesViewModel: FavouritesViewModel(networkService: .mock))
            .environmentObject(UIViewModel())
    }
}
