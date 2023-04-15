//
//  UIModel.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import SwiftUI

public class UIModel: ObservableObject {
    @Published var showTab = true
    @Published var showNav = true

    @Published var showDetail = false
    @Published var selectedMeal = Meals.dummyData[0].id
}
