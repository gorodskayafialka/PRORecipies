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

    @State private var contentHasScrolled = false
    @State private var selectedFeatureMeal: Meal? = nil

    private var featuredMeals = Meals.dummyData1.meals
    private var meals = Meals.dummyData2.meals

    var body: some View {
        ZStack {
            Color("Background")

            if model.showDetail {
                detail
            }

            ScrollView {
                scrollDetection

                Rectangle()
                    .frame(width: 100, height: 72)
                    .opacity(0)

                featured.padding(.bottom, 20)

                Text("Meals".uppercased())
                    .font(.body.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .offset(y: -100)

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
            .coordinateSpace(name: "scroll")
        }
        .onChange(of: model.showDetail) { _ in
            withAnimation {
                model.showTab.toggle()
                model.showNav.toggle()
            }
        }
        .overlay(NavigationBar(title: NavigationTitle.home.rawValue, contentHasScrolled: $contentHasScrolled))
    }

    var detail: some View {
        ForEach(meals) { meal in
            if meal.id == model.selectedMeal {
                MealView(namespace: namespace, meal: meal)
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
                        .shadow(radius: 20, x: 0, y: 20)
                        .blur(radius: abs(reader.frame(in: .global).minX) / 40)
                        .overlay(
                            CacheAsyncImage(url: meal.thumbnailLink.flatMap(URL.init(string:)), content: { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                        .cornerRadius(30)
                                        .padding(.horizontal, 15)
                                        .offset(x: reader.frame(in: .global).minX / 2, y: -60)
                                } else {
                                    ProgressView().offset(y: -30)
                                }
                            }, placeholder: {
                                    ProgressView().offset(y: -30)
                            })
                        )
                        .padding(20)
                        .onTapGesture {
                            selectedFeatureMeal = meal
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 460)
        .fullScreenCover(item: $selectedFeatureMeal) {
            MealView(namespace: namespace, meal: $0)
        }
    }

    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
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
