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

    @State var selectedMeal = Meals.dummyData[0]
    @State var showMeal = false
    
    var meals = Meals.dummyData1
//    lazy var meals : Array<Meal> = {
//        let arr = Array<Meal>()
//        let storage = FavouritesIdsStorage(userDefaults: UserDefaults()).getFavouriteFoodsIds()
//        for i in 0...storage.count {
//            print(1)
//        }
//        return arr
//    }()
    
//    var meals : Array<Meals> = {
//        var arr = Array<Meals>()
//        var backend: NetworkService
//        let storage : Array<String> = FavouritesIdsStorage(userDefaults: UserDefaults()).getFavouriteFoodsIds()
//        for i in 0...storage.count {
//            arr.append(try! await backend.mealByID(storage[i]))
//        }
//        return arr
//    }()

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
        }
        .onChange(of: model.showDetail) { _ in
            withAnimation {
                model.showTab.toggle()
            }
        }
    }

    var detail: some View {
        ForEach(meals) { meal in
            if meal.id == model.selectedMeal {
                
                MealView(namespace: namespace, meal: .constant(meal))
            }
        }
    }

    var meal: some View {
        ForEach(meals) { meal in
            MealItem(namespace: namespace, meal: meal)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(UIModel())
    }
}

extension FavoritesView {
    func loadMeals() async {
        let network = NetworkService(
            baseURL: URLFactory.applicationAPI,
            dataFetcher: DataFetcher(
                fetch: URLSession(configuration: .default, delegate: nil, delegateQueue: .main).fetchRequest)
        )
        
        print(try! await network.mealByID("1"))
    }
}
