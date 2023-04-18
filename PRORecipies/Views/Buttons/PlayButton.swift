//
//  PlayButton.swift
//  PRORecipies
//
//  Created by Anvar on 18.04.2023.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        VStack {
            PlayShape()
                .fill(.ultraThinMaterial)
                .overlay(
                    PlayShape()
                        .stroke(.white)
                )
                .frame(width: 36, height: 36)
        }
        .frame(width: 100, height: 100)
        .background(.ultraThinMaterial)
        .cornerRadius(50)
        .overlay(
            Text("04:20")
                .font(.footnote.weight(.semibold))
                .padding(2)
                .padding(.horizontal, 2)
                .background(Color(.systemBackground).opacity(0.3))
                .cornerRadius(4)
                .offset(y: 34)
        )
        .shadow(radius: 30)
        .overlay(CircularView(value: 0.4, lineWidth: 8))
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton()
    }
}
