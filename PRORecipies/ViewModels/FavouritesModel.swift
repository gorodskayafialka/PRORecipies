//
//  FavouritesModel.swift
//  PRORecipies
//
//  Created by Денис Жимоедов on 17.04.2023.
//

import Foundation

final class FavouritesViewModel: ObservableObject {
    @Published private(set) var favouriteMeals: [Meal] = []
    let storage = FavouritesIdsStorage(userDefaults: UserDefaults())

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
        favouriteMeals = []
        for mealId in mealIds {
            do {
                let favouriteMeal = try await networkService.mealByID(mealId).meals
                favouriteMeals.append(favouriteMeal[0])
            } catch {
                continue
            }
        }
    }
}
