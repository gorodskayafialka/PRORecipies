//
//  CheckboxField.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 18.04.2023.
//

import SwiftUI

struct CheckboxField: View {
    let size: CGFloat = 20
    let color: Color = Color("accenttabcolor")
    @Binding var isMarked: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: self.isMarked ? "checkmark.square" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: self.size, height: self.size)
        }.foregroundColor(self.color)
    }
}
