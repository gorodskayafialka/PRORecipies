//
//  FeaturedMeal.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import SwiftUI

struct FeaturedMeal: View {
    var meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text(meal.name ?? "N/A")
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(meal.category?.uppercased() ?? "N/A")
                .font(.footnote.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.secondary)
            Text(meal.area ?? "N/A")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
    }
}

struct FeaturedMeal_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedMeal(meal: Meals.dummyData[0])
    }
}
