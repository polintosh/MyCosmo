//
//  AcknowledgmentsView.swift
//  MyCosmo
//
//  View displaying acknowledgments and credits for external resources.
//  Lists APIs, documentation, and design resources used in building the app.
//  Demonstrates proper attribution practices for open-source projects.
//
//  Architecture: Settings detail view accessed from main SettingsView.
//

import SwiftUI

// MARK: - AcknowledgmentsView

/// View displaying credits for APIs, documentation, and design resources.
/// Shows proper attribution for external services and tools used in the app.
struct AcknowledgmentsView: View {
    var body: some View {
        List {
            // External APIs Section
            Section("APIs") {
                InfoSheetRow(
                    symbol: "network",
                    title: "NASA APOD",
                    description: "Astronomy Picture of the Day")

                InfoSheetRow(
                    symbol: "newspaper.fill",
                    title: "Space News API",
                    description: "Latest space news and articles")
            }

            // Documentation Resources Section
            Section("Documentation") {
                InfoSheetRow(
                    symbol: "apple.logo",
                    title: "Apple Developer",
                    description: "SwiftUI and iOS documentation")

                InfoSheetRow(
                    symbol: "doc.fill",
                    title: "Swift Documentation",
                    description: "Swift language resources")
            }

            // Design Resources Section
            Section("Design") {
                InfoSheetRow(
                    symbol: "paintpalette.fill",
                    title: "SF Symbols",
                    description: "Apple's icon system")

                InfoSheetRow(
                    symbol: "ruler.fill",
                    title: "Human Interface Guidelines",
                    description: "Apple's design principles")
            }
        }
        .navigationTitle("Acknowledgments")
    }
}

#Preview {
    NavigationStack {
        AcknowledgmentsView()
    }
}
