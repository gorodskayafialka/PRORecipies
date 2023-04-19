//
//  SettingsView.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                List {
                    settingsSection
                        .listRowBackground(Color("tabbar"))

                    linksSection
                        .listRowBackground(Color("tabbar"))
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                .listRowSeparator(.automatic)
            }
            .navigationTitle("Settings")
            .toolbar {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Close")
                }
            }
        }
    }

    var settingsSection: some View {
        Section("Theme") {
            NavigationLink {
                IconsListView()
                    .environmentObject(IconSettings())
            } label: {
                Label("Icons", systemImage: "photo")
            }
        }
    }

    var linksSection: some View {
        Section("Links") {
            if let url = URL(string: "https://www.themealdb.com") {
                Link(destination: url) {
                    HStack {
                        Label("Data Source (API)", systemImage: "internaldrive")
                            .tint(.primary)
                        Spacer()
                        Image(systemName: "link")
                            .tint(.secondary)
                    }
                }
            }

            if let url = URL(string: "https://github.com/gorodskayafialka/PRORecipies") {
                Link(destination: url) {
                    HStack {
                        Label("GitHub", systemImage: "house")
                            .tint(.primary)
                        Spacer()
                        Image(systemName: "link")
                            .tint(.secondary)
                    }
                }
            }
        }
        .listRowSeparator(.automatic)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
