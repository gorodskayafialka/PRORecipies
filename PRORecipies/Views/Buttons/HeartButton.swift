//  HeartButton.swift
//  PRORecipies
//
//  Created by Денис Жимоедов on 15.04.2023.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isFavourite: Bool
    var body: some View {
        Image(systemName: isFavourite ? "heart.fill" : "heart")
            .imageScale(.large)
            .foregroundColor(.secondary)
            .padding(8)
            .background(.ultraThinMaterial, in: Circle())
    }
}

struct HeartButton_Previews: PreviewProvider {
    static var previews: some View {
        HeartButton(isFavourite: .constant(true))
    }
}
