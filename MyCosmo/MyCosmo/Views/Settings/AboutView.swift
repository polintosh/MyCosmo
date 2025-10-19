//
//  AboutView.swift
//  MyCosmo
//
//  View displaying app information, description, and technologies used.
//  Simple informational screen with List layout showcasing project background.
//  Part of the Settings section providing transparency about the app.
//
//  Architecture: Settings detail view accessed from main SettingsView.
//

import SwiftUI

// MARK: - AboutView

/// Informational view displaying app details and technologies.
/// Shows app description, project background, and tech stack.
struct AboutView: View {
    var body: some View {
        List {
            // App Header Section
            Section {
                HStack {
                    Image("IconResource")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("MyCosmo")
                            .font(.headline)
                        Text("Be your universe.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.leading, 8)
                }
                .padding(.vertical, 4)
            }

            // Project Description Section
            Section("About") {
                Text(
                    "MyCosmo started as a simple class project, but as we invested more time and effort, we discovered its potential and the passion we could bring to it. While there are many astronomy apps available, our vision is different. We've made this project open source on GitHub, allowing others to see how it's built and hopefully inspire them to create their own apps. While future developments might lead to a closed version, our current intention is to keep it open and accessible to the community. We hope you enjoy using MyCosmo as much as we enjoyed creating it."
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.vertical, 4)
            }

            // Technologies Section
            Section("Technologies") {
                InfoSheetRow(
                    symbol: "swift",
                    title: "Swift & SwiftUI",
                    description: "Native iOS development")

                InfoSheetRow(
                    symbol: "arrow.triangle.2.circlepath",
                    title: "Async/Await",
                    description: "Modern concurrency")

                InfoSheetRow(
                    symbol: "archivebox.fill",
                    title: "Swift Data",
                    description: "Local data persistence")
            }
        }
        .navigationTitle("About")
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
