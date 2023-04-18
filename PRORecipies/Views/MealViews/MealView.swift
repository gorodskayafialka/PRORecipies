//
//  MealView.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import SwiftUI

struct MealView: View {
    typealias Action = () -> ()

    enum CloseAction {
        case dismiss
        case closeWithAction(Action)
    }

    var namespace: Namespace.ID

    @ObservedObject private var viewModel: MealViewModel
    @State private var appear = false
    @State private var isFavourite = false
    @State private var viewStateSize: CGSize = .zero
    private let storage = FavouritesIdsStorage(storage: PersistentStorage(userDefaults: .standard))

    @Environment(\.dismiss) var dismiss

    private let closeAction: CloseAction

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

            HStack {
                heartButton
                closeButton
            }
            .offset(y: 50)
            .padding(30)
        }
        .ignoresSafeArea()
        .zIndex(1)
        .onAppear { fadeIn() }
    }

    var closeButton: some View {
        Button {
            closeAction.isCustom ? close() : dismiss()
        } label: {
            CloseButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }

    var heartButton: some View {
        Button {
            viewModel.isFavourite.toggle()
        } label: {
            HeartButton(isFavourite: $viewModel.isFavourite)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
                    .matchedGeometryEffect(id: "mask\(viewModel.meal)", in: namespace)
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
        CacheAsyncImage(url: viewModel.meal.thumbnailLink.flatMap(URL.init(string:)), content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "image\(viewModel.meal)", in: namespace)
        }, placeholder: {
            ProgressView()
                .offset(y: -30)
        })
    }

    var card: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.meal.name ?? "N/A")
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
                .matchedGeometryEffect(id: "name\(viewModel.meal)", in: namespace)

            Text(viewModel.meal.category?.uppercased() ?? "N/A")
                .font(.footnote).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary.opacity(0.7))
                .matchedGeometryEffect(id: "category\(viewModel.meal)", in: namespace)

            Text(viewModel.meal.area?.uppercased() ?? "N/A")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary.opacity(0.7))
                .matchedGeometryEffect(id: "area\(viewModel.meal)", in: namespace)
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
            .matchedGeometryEffect(id: "blur\(viewModel.meal)", in: namespace)
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
        ListsSwitcher(ingredientsList: viewModel.meal.ingredients ?? [],
                      instructions: viewModel.meal.instructions ?? "")
        .background(
            blurCard
        )
        .background(
            cardForm
        )
        .padding(20)
        .matchedGeometryEffect(id: "blurSwitch\(viewModel.meal)", in: namespace)
        .opacity(appear ? 1 : 0)
    }

    func close() {
        withAnimation {
            viewStateSize = .zero
        }
        withAnimation(.closeCard.delay(0.2)) {
            closeBlock()
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

extension MealView {
    init(
        namespace: Namespace.ID,
        meal: Meal,
        onClose: @escaping Action
    ){
        self.namespace = namespace
        self.viewModel = MealViewModel(meal: meal)
        self.closeAction = .closeWithAction(onClose)
    }

    init(
        namespace: Namespace.ID,
        meal: Meal
    ){
        self.namespace = namespace
        self.viewModel = MealViewModel(meal: meal)
        self.closeAction = .dismiss
    }
}

extension MealView {
    var closeBlock: Action {
        switch closeAction {
        case .dismiss:
            return { dismiss() }
        case.closeWithAction(let action):
            return action
        }
    }
}

extension MealView.CloseAction {
    fileprivate var isCustom: Bool {
        switch self {
        case .closeWithAction:
            return true
        case .dismiss:
            return false
        }
    }
}


struct MealView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        MealView(namespace: namespace,
                 meal: Meals.dummyData1.meals[0],
                 onClose: { })
    }
}
