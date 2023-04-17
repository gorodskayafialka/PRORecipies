//
//  ExploreViewModel.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published private(set) var meals: [Meal] = []
    @Published var selectedMeal: Meal? = nil

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchSearchedMeals(for text: String = "") {
        Task {
            await fetchMeals(for: text)
        }
    }

    @MainActor
    private func fetchMeals(for text: String) async {
        do {
            meals = try await Array(networkService.search(text).meals.prefix(10))
        } catch {
            return
        }
    }
}
