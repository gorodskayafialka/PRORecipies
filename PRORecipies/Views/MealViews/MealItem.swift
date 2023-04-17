//
//  MealItem.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import SwiftUI

struct MealItem: View {
    var namespace: Namespace.ID
    var meal: Meal

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Text(meal.name ?? "N/A")
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "name\(meal)", in: namespace)
                    .foregroundColor(.white)

                Text(meal.category?.uppercased() ?? "N/A")
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "category\(meal)", in: namespace)
                    .foregroundColor(.white.opacity(0.7))

                Text(meal.area?.uppercased() ?? "N/A")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.7))
                    .matchedGeometryEffect(id: "area\(meal)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(meal)", in: namespace)
            )
        }
        .background(
            CacheAsyncImage(url: meal.thumbnailLink.flatMap(URL.init(string:)), content: { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "image\(meal)", in: namespace)
                } else {
                    ProgressView()
                        .offset(y: -30)
                }
            }, placeholder: {
                ProgressView()
                    .offset(y: -30)
            })
        )
        .mask(
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: "mask\(meal)", in: namespace)
        )
    }

}

struct MealItem_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        MealItem(
            namespace: namespace,
            meal: Meals.dummyData1.meals[0]
        )
    }
}
