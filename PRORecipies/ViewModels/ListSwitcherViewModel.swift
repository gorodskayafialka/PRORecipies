//
//  ListSwitcherViewModel.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 18.04.2023.
//
import Foundation

final class ListSwitcherViewModel: ObservableObject {
    @Published var ingredientsCheckBoxes: [Bool] {
        didSet {
            saveCheckboxesMarks()
        }
    }
    @Published var instructionsCheckBoxes: [Bool] {
        didSet {
            saveCheckboxesMarks()
        }
    }

    private let storage: KeyValueStorage
    public let meal: Meal

    init(meal: Meal, storage: KeyValueStorage = PersistentStorage(userDefaults: .standard)) {
        self.meal = meal
        self.storage = storage
        self.ingredientsCheckBoxes = Array.init(repeating: false, count: self.meal.ingredients?.count ?? 0)
        self.instructionsCheckBoxes = Array.init(repeating: false, count: self.meal.instructions?.count ?? 0)
        getCheckboxesMarks()
    }

    func getCheckboxesMarks() {
        let lists = storage.getMarksLists(mealName: meal.id, ingredArraySize: meal.ingredients?.count ?? 0, instructArraySize: meal.instructions?.count ?? 0)
        ingredientsCheckBoxes = lists[0]
        instructionsCheckBoxes = lists[1]
    }

    private func saveCheckboxesMarks() {
        storage.saveMarksList(mealName: meal.id, lists: [ingredientsCheckBoxes, instructionsCheckBoxes])
    }
}
