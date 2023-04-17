//
//  View+OnShake.swift
//  PRORecipies
//
//  Created by Maksim Neverovskij on 17.04.2023.
//

import SwiftUI

public extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(ShakeDetector(onShake: action))
    }
}

private struct ShakeDetector: ViewModifier {
    let onShake: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: .shakeEnded)) { _ in
                onShake()
            }
    }
}
