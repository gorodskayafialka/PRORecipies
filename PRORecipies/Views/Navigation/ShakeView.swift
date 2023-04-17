//
//  ShakeView.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 16.04.2023.
//

import SwiftUI

struct ShakeView: View {
    @ObservedObject var viewModel: ShakeViewModel
    @Namespace var namespace

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            if let meal = viewModel.meal {
                MealView(namespace: namespace, meal: meal, showDetail: .constant(false))
                    .padding(.bottom, 80)
            }
        }
        .onAppeared {
            viewModel.fetchMealDetail()
        }
        .onShake {
            viewModel.fetchMealDetail()
        }
    }
}
