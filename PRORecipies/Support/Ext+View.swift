//
//  Ext+View.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//
import SwiftUI

extension View {
    func onAppearOnce(_ action: @escaping () -> ()) -> some View {
        self.modifier(OnAppearOnceModifier(action: action))
    }
}
private struct OnAppearOnceModifier: ViewModifier {
    let action: () -> ()
    @State private var appearOnce = true
    func body(content: Content) -> some View {
        content
            .onAppear {
                action()
            }
    }
}
