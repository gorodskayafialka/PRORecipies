//
//  NavigationBar.swift
//  PRORecipies
//
//  Created by Anvar on 15.04.2023.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    @Binding var contentHasScrolled: Bool
    @EnvironmentObject var model: UIModel

    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
                .frame(maxHeight: .infinity, alignment: .top)
                .blur(radius: contentHasScrolled ? 10 : 0)
                .opacity(contentHasScrolled ? 1 : 0)

            Text(title)
                .font(.system(size: contentHasScrolled ? 24 : 34, weight: .bold))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20)
                .padding(.top, 64)
                .opacity(contentHasScrolled ? 0.7 : 1)
        }
        .offset(y: model.showNav ? 0 : -120)
        .accessibility(hidden: !model.showNav)
        .offset(y: contentHasScrolled ? -16 : 0)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(contentHasScrolled: .constant(false))
            .environmentObject(UIModel())
    }
}
