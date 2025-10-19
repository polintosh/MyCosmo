//
//  MainTabView.swift
//  MyCosmo
//
//  Main navigation container using SwiftUI's TabView for app-wide navigation.
//  Provides tab-based access to the four main sections of the app.
//  Each tab contains its own NavigationStack for hierarchical navigation.
//
//  Architecture: Root view in the app's navigation hierarchy.
//

import SwiftUI

// MARK: - MainTabView

/// Root navigation container with tab-based navigation between main app sections.
/// Uses SwiftUI's native TabView component with SF Symbol icons for each tab.
struct MainTabView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper.fill")
                }

            SolarSystemView()
                .tabItem {
                    Label("Solar System", systemImage: "globe.europe.africa.fill")
                }

            ObservationsView()
                .tabItem {
                    Label("Observations", systemImage: "binoculars.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
