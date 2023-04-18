//
//  ListStorage.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 18.04.2023.
//

import Foundation

extension KeyValueStorage {
    func getMarksLists(mealName key: String, ingredArraySize: Int, instructArraySize: Int) -> [[Bool]] {
        self.value(forKey: key, default: [Array(repeating: false, count: ingredArraySize), Array(repeating: false, count: instructArraySize)])
    }

    func saveMarksList(mealName key: String, lists array: [[Bool]]) {
        self.setValue(array, forKey: key)
    }
}
