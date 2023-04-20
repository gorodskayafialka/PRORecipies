//
//  SettingsView.swift
//  PRORecipies
//
//  Created by Anvar on 17.04.2023.
//

import SwiftUI
import Charts

struct SettingsView: View {
    @StateObject var settingsViewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                List {
                    barChart

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
            .onAppear {
                settingsViewModel.fetchMeals()
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

    var barChart: some View {
        Section("Statistics") {
            Chart {
                ForEach(Array(settingsViewModel.countries.keys), id: \.self) { key in
                    BarMark(
                        x: .value("Country", settingsViewModel.countries[key] ?? -1),
                        y: .value("Country", key)
                    )
                    .foregroundStyle(by: .value("Count", key))
                }
            }
            .chartLegend(.hidden)
            .padding(10)
            .frame(height: 250)
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
        SettingsView(settingsViewModel: SettingsViewModel(networkService: .mock))
    }
}
