//
//  OnAppearedOnceModifier.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//

import SwiftUI

extension View {
    func onAppearedOnce(_ action: @escaping () -> ()) -> some View {
        self.modifier(OnAppearedModifier(action: action))
    }
}

private struct OnAppearedModifier: ViewModifier {
    let action: () -> ()
    @State private var appearedOnce = true

    func body(content: Content) -> some View {
        content
            .onAppear {
                if appearedOnce {
                    appearedOnce = false
                    action()
                }
            }
    }
}
