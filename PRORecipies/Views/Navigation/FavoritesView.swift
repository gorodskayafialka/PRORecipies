//
//  FavoritesView.swift
//  PRORecipies
//
//  Created by Anvar on 11.04.2023.
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var uiViewModel: UIViewModel
    @StateObject var favouritesViewModel: FavouritesViewModel
    @Namespace var namespace

    @State private var contentHasScrolled = false
    @State private var selectedFeatureMeal: Meal? = nil


    var body: some View {
        ZStack {
            Color("Background")

            if favouritesViewModel.showDetail {
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
                list
                    .padding(.horizontal, 20)
                    .offset(y: -110)
            }
            .coordinateSpace(name: "scroll")
        }
        .onAppeared() {
            favouritesViewModel.fetchFavouritesMeals()
        }
        .onChange(of: favouritesViewModel.showDetail) { _ in
            withAnimation {
                uiViewModel.showTab.toggle()
                uiViewModel.showNav.toggle()
            }
        }
        .overlay(NavigationBar(title: NavigationTitle.home.rawValue, contentHasScrolled: $contentHasScrolled))
    }

    var list: some View {
        LazyVStack(spacing: 20) {
            meal.frame(height: 300)
        }
    }

    var detail: some View {
        ForEach(favouritesViewModel.meals) { meal in
            if meal.id == favouritesViewModel.selectedMeal {
                MealView(namespace: namespace, meal: meal, showDetail: $favouritesViewModel.showDetail) {
                    favouritesViewModel.selectedMeal = Meal.notFoundId
                }
            }
        }
    }

    var meal: some View {
        ForEach(favouritesViewModel.favouriteMeals) { meal in
            MealItem(namespace: namespace, meal: meal, selectedMeal: $favouritesViewModel.selectedMeal, showDetail: $homeViewModel.showDetail)
        }
    }

    var featured: some View {
        TabView {
            ForEach(favouritesViewModel.featuredMeals) { meal in
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
        .fullScreenCover(item: $selectedFeatureMeal) { meal in
            MealView(namespace: namespace, meal: meal, showDetail: $favouritesViewModel.showDetail)
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(homeViewModel: FavouritesViewModel(networkService: .mock))
            .environmentObject(UIViewModel())
    }
}
