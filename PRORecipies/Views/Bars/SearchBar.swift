//
//  SearchBar.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack {

            TextField("Search for a meal", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }

            if isEditing {
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                        self.text = ""
                    }
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Meal"))
    }
}
