    //
//  PlayButtonView.swift
//  PRORecipies
//
//  Created by Anvar on 18.04.2023.
//

import SwiftUI

struct PlayButtonView: View {
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
        .offset(x: 3)
        .frame(width: 80, height: 80)
        .background(.ultraThinMaterial)
        .cornerRadius(40)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}
