//
//  MainTabView.swift
//  MyCosmo
//
//  Main navigation container using SwiftUI's TabView for app-wide navigation.
//  Provides tab-based access to the four main sections of the app.
//  Each tab contains its own NavigationStack for hierarchical navigation.
//
//  Architecture: Root view in the app's navigation hierarchy.
//  Uses iOS 18's Tab(_:systemImage:content:) initializer and .sidebarAdaptable
//  style (becomes a sidebar on iPad) plus iOS 26's .tabBarMinimizeBehavior,
//  which lets the Liquid Glass tab bar collapse as scrolling content passes under it.
//

import SwiftUI

// MARK: - MainTabView

/// Root navigation container with tab-based navigation between main app sections.
/// Uses SwiftUI's Tab-based TabView with SF Symbol icons for each tab.
struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("News", systemImage: "newspaper.fill") {
                NewsView()
            }

            Tab("Solar System", systemImage: "globe.europe.africa.fill") {
                SolarSystemView()
            }

            Tab("Observations", systemImage: "binoculars.fill") {
                ObservationsView()
            }

            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    MainTabView()
}
