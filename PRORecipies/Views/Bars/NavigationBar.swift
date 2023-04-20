//
//  NavigationBar.swift
//  PRORecipies
//
//  Created by Anvar on 15.04.2023.
//

import SwiftUI

struct NavigationBar: View {
    var title: String
    @Binding var contentHasScrolled: Bool
    @Binding var showSheet: Bool
    @EnvironmentObject var uiViewModel: UIViewModel

    var body: some View {
        ZStack {
            blur

            navigationTitle

            settingsButton
        }
        .offset(y: uiViewModel.showNav ? 0 : -120)
        .accessibility(hidden: !uiViewModel.showNav)
        .offset(y: contentHasScrolled ? -16 : 0)

    }

    var settingsButton: some View {
        Button {
            showSheet.toggle()
        } label: {
            Image(systemName: Icons.gear.rawValue)
                .imageScale(.medium)
                .frame(width: 36, height: 36)
                .foregroundColor(.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(.top, 64)
        .padding(.horizontal, 20)
    }

    var navigationTitle: some View {
        Text(title)
            .font(.system(size: contentHasScrolled ? 24 : 34, weight: .bold))
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 20)
            .padding(.top, 64)
            .opacity(contentHasScrolled ? 0.7 : 1)
    }

    var blur: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 110)
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            .frame(maxHeight: .infinity, alignment: .top)
            .blur(radius: contentHasScrolled ? 10 : 0)
            .opacity(contentHasScrolled ? 1 : 0)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Navigation", contentHasScrolled: .constant(false), showSheet: .constant(false))
            .environmentObject(UIViewModel())
    }
}
