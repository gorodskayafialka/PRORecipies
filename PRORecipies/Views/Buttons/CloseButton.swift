//
//  CloseButton.swift
//  PRORecipies
//
//  Created by Anvar on 12.04.2023.
//

import SwiftUI

struct CloseButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .imageScale(.large)
            .foregroundColor(.secondary)
            .padding(8)
            .background(.ultraThinMaterial, in: Circle())
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
