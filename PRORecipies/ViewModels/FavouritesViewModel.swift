//
//  FavouritesViewModel.swift
//  PRORecipies
//
//  Created by Денис Жимоедов on 17.04.2023.
//

import Foundation

final class FavouritesViewModel: ObservableObject {
    @Published var showDetail = false
    @Published private(set) var favouriteMeals: [Meal] = []
    @Published var selectedMeal = Meal.notFoundId


    private let storage = FavouritesIdsStorage(storage: PersistentStorage(userDefaults: .standard))
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchFavouritesMeals() {
        Task {
            await fetchFavourites()
        }
    }

    @MainActor
    private func fetchFavourites() async {
        let mealIds = storage.getFavouriteFoodsIds()
        var favouriteTmpMeals: [Meal] = []
        for mealId in mealIds {
            do {
                if let favouriteMealFirst = try await networkService.mealByID(mealId).meals.first {
                    favouriteTmpMeals.append(favouriteMealFirst)
                }
            } catch {
                continue
            }
        }
        favouriteMeals = favouriteTmpMeals
    }
}
