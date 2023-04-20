//
//  HomeView.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var uiViewModel: UIViewModel
    @StateObject var homeViewModel: HomeViewModel
    @Namespace var namespace
    @Binding var showSheet: Bool

    @State private var contentHasScrolled = false
    @State private var selectedFeatureMeal: Meal? = nil
    @State private var selectedDetailMeal: Meal? = nil

    var body: some View {
        ZStack {
            Color("Background")

            if let meal = selectedDetailMeal {
                MealView(namespace: namespace, meal: meal) {
                    selectedDetailMeal = nil
                }
            }

            ScrollView {
                scrollDetection

                Rectangle()
                    .frame(width: 100, height: 72)
                    .opacity(0)

                featured.padding(.bottom, 20)

                Rectangle()
                    .frame(height: 44)
                    .opacity(0)

                Text("Meals".uppercased())
                    .font(.body.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .offset(y: -100)

                if selectedDetailMeal != nil {
                    dummyList
                        .padding(.horizontal, 20)
                        .offset(y: -110)
                } else {
                    list
                        .padding(.horizontal, 20)
                        .offset(y: -110)
                }
            }
            .coordinateSpace(name: "scroll")
        }
        .onAppearedOnce() {
            homeViewModel.fetchMeals()
        }
        .onChange(of: selectedDetailMeal) { _ in
            withAnimation {
                uiViewModel.showTab.toggle()
                uiViewModel.showNav.toggle()
            }
        }
        .overlay(NavigationBar(title: NavigationTitle.home.rawValue, contentHasScrolled: $contentHasScrolled, showSheet: $showSheet))
    }

    var list: some View {
        LazyVStack(spacing: 20) {
            ForEach(homeViewModel.meals) { meal in
                MealItem(
                    namespace: namespace,
                    meal: meal
                ).onTapGesture {
                    withAnimation(.openCard) {
                        selectedDetailMeal = meal
                    }
                }
            }
            .frame(height: 300)
        }
    }

    var dummyList: some View {
        LazyVStack(spacing: 20) {
            ForEach(homeViewModel.featuredMeals) { _ in
                Rectangle()
                    .fill(.white)
                    .frame(height: 300)
                    .cornerRadius(30)
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 10)
                    .opacity(0.3)
            }
        }
    }

    var featured: some View {
        TabView {
            ForEach(homeViewModel.featuredMeals) { meal in
                GeometryReader { reader in
                    FeaturedMeal(meal: meal)
                        .rotation3DEffect(
                            .degrees(reader.frame(in: .global).minX / -10),
                            axis: (x: 0, y: 1, z: 0), perspective: 1
                        )
                        .shadow(radius: 20, x: 0, y: 20)
                        .blur(radius: abs(reader.frame(in: .global).minX) / 40)
                        .overlay(
                            CacheAsyncImage(url: meal.thumbnailLink.flatMap(URL.init(string:)), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 200)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 15)
                                    .offset(x: reader.frame(in: .global).minX / 2, y: -60)
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
        .tabViewStyle(.page)
        .frame(height: 420)
        .fullScreenCover(item: $selectedFeatureMeal) { meal in
            MealView(namespace: namespace, meal: meal)
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
        HomeView(homeViewModel: HomeViewModel(networkService: .mock), showSheet: .constant(false))
            .environmentObject(UIViewModel())
    }
}

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
