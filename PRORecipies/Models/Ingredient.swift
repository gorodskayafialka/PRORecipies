//
//  Ingredient.swift
//  PRORecipies
//
//  Created by Anvar on 13.04.2023.
//

import Foundation

struct Ingredient {
    let name: String
    let measure: String?
}

struct FullIngredients: Decodable {
    enum CodingKeys: String, CodingKey {
        case meals
    }

    let meals: [FullIngredient]
}

struct FullIngredient: Decodable {
    let id: String // idIngredient
    let name: String? // strIngredient
    let description: String? // strDescription
    let type: String? // strType

    private enum RequiredCodingKeys: String, CodingKey, CaseIterable {
        case idIngredient
    }

    private enum OptionalCodingKeys: String, CodingKey, CaseIterable {
        case strIngredient
        case strDescription
        case strType
    }

    init(from decoder: Decoder) throws {
        let commonContainer = try decoder.container(keyedBy: RequiredCodingKeys.self)
        id = try commonContainer.decode(String.self, forKey: .idIngredient)

        let customContainer = try decoder.container(keyedBy: OptionalCodingKeys.self)
        name = try customContainer.decode(String.self, forKey: .strIngredient)
        description = try customContainer.decodeIfPresent(String.self, forKey: .strDescription)
        type = try customContainer.decodeIfPresent(String.self, forKey: .strType)
    }
}

struct IngredientsUIData {
    let ingredients: [IngredientUIData]
}

struct IngredientUIData {
    let title: String?
    let type: String?
    let description: String?
}
