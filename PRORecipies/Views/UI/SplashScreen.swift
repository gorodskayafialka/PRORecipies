//
//  SplashScreen.swift
//  PRORecipies
//
//  Created by Anvar on 19.04.2023.
//

import SwiftUI

struct SplashScreen: View {
    @State var animate = false
    @State var endSplash = false

    var body: some View {
        ZStack {
            Color("Background")

            Image("logo_big")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: animate ? .fill : .fit)
                .frame(width: animate ? nil : 100, height: animate ? nil : 100)
                .scaleEffect(animate ? 3 : 1)
                .frame(width: UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
        .onAppear(perform: animateSplash)
        .opacity(endSplash ? 0 : 1)
    }

    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: 0.5)) {
                animate.toggle()
            }
            withAnimation(.linear(duration: 0.35)) {
                endSplash.toggle()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
