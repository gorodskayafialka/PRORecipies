//
//  CustomSegmentedControl.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 14.04.2023.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: List
    var options: [List]
    let color = Color("Shadow")

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id: \.self) { index in
                let isSelected = preselectedIndex == options[index]
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.2))
                    Rectangle()
                        .fill(color)
                        .cornerRadius(35)
                        .padding(2)
                        .opacity(isSelected ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.2,
                                                             dampingFraction: 2,
                                                             blendDuration: 0.5)) {
                                preselectedIndex = options[index]
                            }
                        }
                }
                .overlay(
                    Text(options[index].rawValue)
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(isSelected ? .primary : .gray)
                )
            }
        }
        .frame(height: 55)
        .cornerRadius(35)
    }
}
