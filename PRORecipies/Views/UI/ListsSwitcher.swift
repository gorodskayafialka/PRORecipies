//
//  ListsSwitcher.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 14.04.2023.
//

import SwiftUI

enum Lists: String {
    case ingredients = "Ingredients"
    case recepie = "Recepie"
}

extension String {
    fileprivate func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}

struct ListsSwitcher: View {
    @State private var chosenList = Lists.ingredients
    private let ingredientsList: [Ingredient]
    private let recepieList: [String]
    init(ingredientsList: [Ingredient], instructions: String) {
        self.ingredientsList = ingredientsList
        self.recepieList = InstructionsParser.parse(instruction: instructions)
    }
    var body: some View {
        VStack {
            CustomSegmentedControl(preselectedIndex: $chosenList, options: [Lists.ingredients, Lists.recepie])

            switch chosenList {
            case .ingredients:
                ForEach(ingredientsList.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("\(index + 1). \(ingredientsList[index].name.capitalizingFirstLetter())")
                            Spacer()
                            Text("\(ingredientsList[index].measure ?? "")")
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .font(.title3)
                    }
                    if index != ingredientsList.count - 1 {
                        Divider().padding(.horizontal, 30)
                    }
                }
            case .recepie:
                ForEach(recepieList.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("\(index + 1). \(recepieList[index].capitalizingFirstLetter())")
                            Spacer()
                        }.padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .font(.title3)
                    }

                    if index != recepieList.count - 1 {
                        Divider().padding(.horizontal, 30)
                    }
                }
            }
        }
        .foregroundColor(.primary)
        .padding(.bottom, 10)
    }
}
