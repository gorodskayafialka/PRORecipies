//
//  ListMeal.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//

import SwiftUI

struct RowMeal: View {
    var meal: Meal

    var body: some View {
        HStack {
            CacheAsyncImage(url: meal.thumbnailLink.flatMap(URL.init(string:)), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.vertical, 20)
            }, placeholder: {
                Rectangle()
                    .redacted(reason: .placeholder)
            })
            .frame(width: 100, height: 100)
            .cornerRadius(30)

            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text(meal.name ?? "N/A")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    .minimumScaleFactor(0.7)
                Text(meal.category?.uppercased() ?? "N/A")
                    .font(.footnote.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
                Text(meal.area ?? "N/A")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
        }
        .frame(height: 120)
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
    }
}

struct RowMeal_Previews: PreviewProvider {
    static var previews: some View {
        RowMeal(meal: Meals.dummyData1.meals[0])
    }
}
