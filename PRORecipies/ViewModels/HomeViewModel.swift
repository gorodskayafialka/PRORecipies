//
//  HomeViewModel.swift
//  PRORecipies
//
//  Created by Kirill Aldonin on 15.04.2023.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published private(set) var featuredMeals: [Meal] = []
    @Published private(set) var meals: [Meal] = []
    @Published var selectedMeal: Meal.ID = Meal.notFoundId
    
    private let backend: NetworkService
    
    init(backend: NetworkService) {
        self.backend = backend
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
            featuredMeals = try await backend.setRandomMeals().meals
        } catch {
            return
        }
    }
    
    @MainActor
    private func fetchMain() async {
        do {
            meals = try await backend.latestMeals().meals
        } catch {
            return
        }
    }
}

extension Meal {
    static var notFoundId: ID {
        "-1"
    }
}
