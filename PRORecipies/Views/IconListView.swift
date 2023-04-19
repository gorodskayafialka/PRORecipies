//
//  IconPickerView.swift
//  PRORecipies
//
//  Created by Anvar on 19.04.2023.
//

import SwiftUI
struct IconsListView: View {
    @EnvironmentObject var iconSettings: IconSettings

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            Form {
                Picker("App Icon", selection: $iconSettings.iconIndex) {
                    ForEach(iconSettings.icons.indices, id: \.self) { index in
                        IconRow(icon: iconSettings.icons[index])
                            .tag(index)
                    }
                }
                .listRowBackground(Color("tabbar"))
                .pickerStyle(.inline)
                .listRowSeparator(.automatic)
                .onChange(of: iconSettings.iconIndex) { newIndex in
                    guard UIApplication.shared.supportsAlternateIcons else { return }

                    let currentIndex = iconSettings.icons.firstIndex(where: { icon in
                        return icon.iconName == iconSettings.currentIconName
                    }) ?? 0
                    guard newIndex != currentIndex else { return }
                    let newIconSelection = iconSettings.icons[newIndex].iconName
                    UIApplication.shared.setAlternateIconName(newIconSelection) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct IconRow: View {

    public let icon: Icon

    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: icon.image ?? UIImage())
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .padding(.trailing)
            Text(icon.displayName)
                .bold()
        }
        .padding(8)
    }
}
