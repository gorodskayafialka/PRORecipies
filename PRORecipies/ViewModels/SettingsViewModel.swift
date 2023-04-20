//
//  SettingsViewModel.swift
//  PRORecipies
//
//  Created by Anvar on 20.04.2023.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published private(set) var meals: [Meal] = []
    @Published var countries = [String: Int]()


    private let storage = FavouritesIdsStorage(storage: PersistentStorage(userDefaults: .standard))
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func makeCountries(from: [Meal]) {
        for meal in meals {
            guard let country = meal.area else { continue }
            countries[country, default: 0] += 1
        }
    }

    func fetchMeals() {
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
        meals = favouriteTmpMeals.reversed()
        makeCountries(from: meals)
    }
}
