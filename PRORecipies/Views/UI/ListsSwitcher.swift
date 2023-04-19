//
//  ListsSwitcher.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 14.04.2023.
//

import SwiftUI

enum Lists: String {
    case ingredients = "Ingredients"
    case recipe = "Recipe"
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
    @StateObject var listViewModel: ListSwitcherViewModel

    init(ingredientsList: [Ingredient], instructions: String, meal: Meal) {
        self.ingredientsList = ingredientsList
        self.recepieList = InstructionsParser.parse(instruction: instructions)
        _listViewModel = StateObject(wrappedValue: ListSwitcherViewModel(meal: meal))
    }

    var body: some View {
        VStack {
            CustomSegmentedControl(preselectedIndex: $chosenList, options: [Lists.ingredients, Lists.recipe])

            switch chosenList {
            case .ingredients:
                ForEach(ingredientsList.indices, id: \.self) { index in

                    HStack(alignment: .top) {
                        CheckboxField(isMarked: $listViewModel.ingredientsCheckBoxes[index])
                            .onTapGesture {
                                listViewModel.ingredientsCheckBoxes[index].toggle()
                            }
                            .padding(.top, 5)
                            .padding(.trailing, 5)

                        HStack {
                            Text("\(index + 1). \(ingredientsList[index].name.capitalizingFirstLetter())")
                            Spacer()
                            Text("\(ingredientsList[index].measure ?? "")")
                        }
                    }.padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .font(.title3)

                    if index != ingredientsList.count - 1 {
                        Divider().padding(.horizontal, 30)
                    }
                }
            case .recipe:
                ForEach(recepieList.indices, id: \.self) { index in

                    HStack(alignment: .top) {
                        CheckboxField(isMarked: $listViewModel.instructionsCheckBoxes[index])
                            .onTapGesture {
                                listViewModel.instructionsCheckBoxes[index].toggle()
                            }
                            .padding(.top, 5)
                            .padding(.trailing, 5)

                        HStack {
                            Text("\(index + 1). \(recepieList[index].capitalizingFirstLetter())")
                            Spacer()
                        }
                    }.padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .font(.title3)

                    if index != recepieList.count - 1 {
                        Divider().padding(.horizontal, 30)
                    }
                }
            }
        }
        .foregroundColor(.primary)
        .padding(.bottom, 10)
        .onAppear{
            listViewModel.getCheckboxesMarks()
        }
    }
}
