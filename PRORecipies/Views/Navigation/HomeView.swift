//
//  HomeView.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: UIModel
    @Namespace var namespace

    @State var selectedMeal = Meals.dummyData[0]
    @State var showMeal = false
    var featuredMeals = Meals.dummyData
    var meals = Meals.dummyData1

    var body: some View {
        ZStack {
            Color("Background")

            if model.showDetail {
                detail
            }

            ScrollView {

                // TODO: make reusable subview
                Text("Featured")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 50)

                featured

                // TODO: make reusable subview
                Text("Meals")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .offset(y: -110)

                if model.showDetail {
                    LazyVStack(spacing: 20) {
                        ForEach(featuredMeals) { _ in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                        }
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -110)
                } else {
                    LazyVStack(spacing: 20) {
                        meal.frame(height: 300)
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -110)
                }
            }
        }
        .onChange(of: model.showDetail) { _ in
            withAnimation {
                model.showTab.toggle()
            }
        }
    }

    var detail: some View {
        ForEach(meals) { meal in
            if meal.id == model.selectedMeal {
                MealView(namespace: namespace, meal: .constant(meal))
            }
        }
    }

    var meal: some View {
        ForEach(meals) { meal in
            MealItem(namespace: namespace, meal: meal)
        }
    }

    var featured: some View {
        TabView {
            ForEach(featuredMeals) { meal in
                GeometryReader { reader in
                    FeaturedMeal(meal: meal)
                        .rotation3DEffect(
                            .degrees(reader.frame(in: .global).minX / -10),
                            axis: (x: 0, y: 1, z: 0), perspective: 1
                        )
                        .shadow(color: Color("Shadow").opacity(0.3),
                                radius: 30, x: 0, y: 30)
                        .blur(radius: abs(reader.frame(in: .global).minX) / 40)
                        .overlay(
                            Image("Food")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .cornerRadius(30)
                                .padding(.horizontal, 15)
                                .offset(x: reader.frame(in: .global).minX / 2, y: -60)
                        )
                        .padding(20)
                        .onTapGesture {
                            showMeal = true
                            selectedMeal = meal
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 460)
        .fullScreenCover(isPresented: $showMeal) {
            MealView(namespace: namespace, meal: $selectedMeal)
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UIModel())
    }
}

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
