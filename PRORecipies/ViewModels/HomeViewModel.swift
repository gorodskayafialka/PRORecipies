//
//  HomeViewModel.swift
//  PRORecipies
//
//  Created by Anvar on 15.04.2023.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published private(set) var featuredMeals: [Meal] = []
    @Published private(set) var meals: [Meal] = []

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchMeals() {
        Task {
            await fetchFeatured()
            await fetchMain()
        }
    }

    @MainActor
    private func fetchFeatured() async {
        do {
            featuredMeals = try await networkService.latestMeals().meals
        } catch {
            return
        }
    }

    @MainActor
    private func fetchMain() async {
        do {
            meals = try await networkService.setRandomMeals().meals
        } catch {
            return
        }
    }
}
