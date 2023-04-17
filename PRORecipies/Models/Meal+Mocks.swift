//
//  Mocks.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import Foundation

extension Meals {
    static var singleDummyData = Self(meals: [
        Meal.dummy1
    ])

    static var dummyData1 = Self(meals: [
        Meal.dummy1,
        Meal.dummy2,
        Meal.dummy3,
    ])

    static var dummyData2 = Self(meals: [
        Meal.dummy4,
        Meal.dummy5,
    ])
}

extension Meal {
    fileprivate static var dummy1 = Self(
        id: "52768",
        name: "Apple Frangipan Tart",
        thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
        category: "Dessert",
        area: "British",
        instructions: """
        Preheat the oven to 200C180C Fan. Gas 6.
        Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs.
        Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.
        """,
        youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk",
        tags: ["butter", "softened"],
        ingredients: [])

    fileprivate static var dummy2 = Self(
        id: "5943953",
        name: "Apple Frangipan Tart",
        thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
        category: "Dessert",
        area: "British",
        instructions: """
        "Preheat the oven to 200C180C Fan. Gas 6.
        Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs.
        Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.
        """,
        youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk",
        tags: ["butter", "softened"],
        ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5))

    fileprivate static var dummy3 = Self(
        id: "34022049",
        name: "Apple Frangipan Tart",
        thumbnailLink: "https://www.themealdb.com/images/media/meals/qstyvs1505931190.jpg",
        category: "Dessert",
        area: "British",
        instructions: """
        "Preheat the oven to 200C180C Fan. Gas 6.
        Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs.
        Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.
        """,
        youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk",
        tags: ["butter", "softened"],
        ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5))

    fileprivate static var dummy4 = Self(
        id: "jgsjgk",
        name: "Apple Frangipan Tart",
        thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
        category: "Dessert",
        area: "British",
        instructions: """
        Preheat the oven to 200C180C Fan. Gas 6.
        Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs.
        Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.
        """,
        youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk",
        tags: ["butter", "softened"],
        ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5))

    fileprivate static var dummy5 = Self(
        id: "gdkjsgdkj",
        name: "Apple Frangipan Tart",
        thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
        category: "Dessert",
        area: "British",
        instructions: """
        Preheat the oven to 200C180C Fan. Gas 6.
        Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs.
        Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.
        """,
        youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk",
        tags: ["butter", "softened"],
        ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5))
}
