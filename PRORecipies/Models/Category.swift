//
//  Category.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import Foundation

struct Categories: Decodable {
    enum CodingKeys: String, CodingKey {
        case categories
    }

    let categories: [Category]
}

struct Category {
    let id: String // idCategory
    let name: String? // strCategory
    let thumbnailLink: String? // strCategoryThumb
    let description: String? // strCategoryDescription
}

extension Category: Decodable {
    private enum RequiredCodingKeys: String, CodingKey, CaseIterable {
        case strCategory
        case idCategory
        case strCategoryThumb
    }

    private enum OptionalCodingKeys: String, CodingKey, CaseIterable {
        case strCategoryDescription
    }

    init(from decoder: Decoder) throws {
        let commonContainer = try decoder.container(keyedBy: RequiredCodingKeys.self)

        id = try commonContainer.decode(String.self, forKey: .idCategory)

        name = try commonContainer.decodeIfPresent(String.self, forKey: .strCategory)

        thumbnailLink = try commonContainer.decodeIfPresent(String.self, forKey: .strCategoryThumb)

        let customContainer = try decoder.container(keyedBy: OptionalCodingKeys.self)

        description = try customContainer.decodeIfPresent(String.self, forKey: .strCategoryDescription)
    }
}
