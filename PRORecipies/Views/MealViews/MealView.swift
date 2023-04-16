//
//  MealView.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import SwiftUI

struct MealView: View {
    var namespace: Namespace.ID
    var meal: Meal
    @State var viewStateSize: CGSize = .zero
    @State var appear = false
    @Binding var showDetail: Bool
    var onClose: (() -> ())? = nil

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    cover
                    listSwitcherForm
                }
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: appear ? 0 : 30))
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            closeButton
        }
        .zIndex(1)
        .onAppear { fadeIn() }
        .onChange(of: showDetail) { _ in
           fadeOut()
        }
    }

    var closeButton: some View {
        Button {
            showDetail ? close() : dismiss()
        } label: {
            CloseButton()
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .offset(y: showDetail ? 50 : 0)
    }

    var cover: some View {
        GeometryReader { reader in
            let scrollY = reader.frame(in: .named("scroll")).minY

            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(
                banner
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear ? 0 : 30)
                    .matchedGeometryEffect(id: "mask\(meal)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .overlay(
                card
                    .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: 100)
                    .padding(20)
                    .padding(.bottom, 20)
            )
        }
        .frame(height: UIScreen.main.bounds.width)
        .padding(.bottom, 50)
    }

    var banner: some View {
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

    }

    var card: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(meal.name ?? "N/A")
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
                .matchedGeometryEffect(id: "name\(meal)", in: namespace)

            Text(meal.category?.uppercased() ?? "N/A")
                .font(.footnote).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary.opacity(0.7))
                .matchedGeometryEffect(id: "category\(meal)", in: namespace)

            Text(meal.area?.uppercased() ?? "N/A")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary.opacity(0.7))
                .matchedGeometryEffect(id: "area\(meal)", in: namespace)
        }
        .padding(20)
        .padding(.vertical, 10)
        .background(
            blurCard
        )
        .background(
            cardForm
        )
    }

    var blurCard: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .cornerRadius(30)
            .blur(radius: 30)
            .matchedGeometryEffect(id: "blur\(meal)", in: namespace)
            .opacity(appear ? 0 : 1)
    }

    var cardForm: some View {
        Rectangle()
           .fill(.ultraThinMaterial)
           .cornerRadius(30)
           .shadow(radius: 5)
           .opacity(appear ? 1 : 0)
    }

    var listSwitcherForm: some View {
        ListsSwitcher(ingredientsList: meal.ingredients ?? [],
                      instructions: meal.instructions ?? "")
        .background(
            blurCard
        )
        .background(
            cardForm
        )
        .padding(20)
        .matchedGeometryEffect(id: "blurSwitch\(meal)", in: namespace)
        .opacity(appear ? 1 : 0)
    }

    func close() {
        withAnimation {
            viewStateSize = .zero

        }
        withAnimation(.closeCard.delay(0.2)) {
            showDetail = false
            guard let onClose = onClose else { return }
            onClose()
        }
    }

    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear = true

        }
    }

    func fadeOut() {
        withAnimation(.easeIn(duration: 0.1)) {
            appear = false

        }
    }
}

struct MealView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        MealView(
            namespace: namespace,
            meal: Meals.dummyData1.meals[0],
            showDetail: .constant(true),
            onClose: { }
        )
    }
}
