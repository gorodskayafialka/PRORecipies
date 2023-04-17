//
//  HomeView.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var model: UIModel
    @Namespace var namespace
    @State var showMeal = false
    @StateObject var favouriteViewModel: FavouritesViewModel
//    private var meals = Meals.dummyData2.meals
    var body: some View {
        ZStack {
            Color("Background")
            if model.showDetail {
                detail
            }
            ScrollView {
                // TODO: make reusable subview
                Text("Favourite meals")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 50)

                LazyVStack(spacing: 20) {
                    meal.frame(height: 300)
                }
                .padding(.horizontal, 20)
            }
        }.onAppear {
            favouriteViewModel.fetchFavouritesMeals()
        }
        .onChange(of: model.showDetail) { _ in
            withAnimation {
                model.showTab.toggle()
            }
        }
    }

    var detail: some View {
        ForEach(favouriteViewModel.favouriteMeals) { meal in
            if meal.id == model.selectedMeal {
                MealView(namespace: namespace, meal: meal)
            }
        }
    }

    var meal: some View {
        ForEach(favouriteViewModel.favouriteMeals) { meal in
            MealItem(namespace: namespace, meal: meal)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        let model = FavouritesViewModel(networkService: .makeUrlSessionedService())
        FavoritesView(favouriteViewModel: model).environmentObject(UIModel())
    }
}
