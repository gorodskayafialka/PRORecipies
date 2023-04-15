//
//  Mocks.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import Foundation

extension Categories {
    static private var dummyCategory = Category(id: "1", name: "Beef", thumbnailLink: "https://www.themealdb.com/images/category/beef.png", description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]")

    static public var dummyData = Array(repeating: dummyCategory, count: 5)
}

extension Meals {
    static private var dummyMeal = Meal(id: "52768", name: "Apple Frangipan Tart", thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C180C Fan. Gas 6. Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.", youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk", tags: ["butter", "softened"], ingredients: [])

    static public var dummyData = Array(repeating: dummyMeal, count: 5)

    static public var dummyData1 = [
        Meal(id: "5943953", name: "Apple Frangipan Tart", thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C180C Fan. Gas 6. Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.", youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk", tags: ["butter", "softened"], ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5)),
        Meal(id: "34022049", name: "Apple Frangipan Tart", thumbnailLink: "https://www.themealdb.com/images/media/meals/qstyvs1505931190.jpg", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C180C Fan. Gas 6. Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.", youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk", tags: ["butter", "softened"], ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5))
        ]

        static public var dummyData2 = [
            Meal(id: "jgsjgk", name: "Apple Frangipan Tart", thumbnailLink: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C180C Fan. Gas 6. Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.", youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk", tags: ["butter", "softened"], ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5)),
            Meal(id: "gdkjsgdkj", name: "Apple Frangipan Tart", thumbnailLink: "https://www.themealdb.com/images/media/meals/qstyvs1505931190.jpg", category: "Dessert", area: "British", instructions: "Preheat the oven to 200C180C Fan. Gas 6. Put the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter.", youTubeLink: "https://www.youtube.com/watch?v=rp8Slv4INLk", tags: ["butter", "softened"], ingredients: Array(repeating: Ingredient(name: "digestive buscuits", measure: "175/12oz"), count: 5))
    ]
}
