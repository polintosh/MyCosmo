//
//  InfoSheet.swift
//  MyCosmo
//
//  Reusable sheet component for displaying feature and technology information.
//  Demonstrates SwiftUI component composition with structured data display.
//  Used throughout the app to show feature details and implementation info.
//
//  Architecture: Reusable UI component in the View layer.
//  The icon badge uses iOS 26's .glassEffect() instead of a manual
//  color-scheme-conditional Circle fill + shadow.
//

import SwiftUI

// MARK: - InfoSheetContent

/// Data structure for information sheet content.
/// Separates content from presentation for reusability.
struct InfoSheetContent {
    let icon: String
    let title: String
    let subtitle: String
    let features: [(symbol: String, title: String, description: String)]
    let technologies: [(symbol: String, title: String, description: String)]
}

// MARK: - InfoSheet

/// Reusable sheet view for displaying app features and technologies.
/// Presents content in sections with consistent styling and layout.
struct InfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    let content: InfoSheetContent

    var body: some View {
        NavigationStack {
            List {
                // Header Section
                Section {
                    VStack(spacing: 16) {
                        // Icon Badge - Liquid Glass adapts to light/dark automatically,
                        // replacing the old manual colorScheme-conditional fill + shadow.
                        Image(systemName: content.icon)
                            .font(.system(size: 40))
                            .foregroundStyle(colorScheme == .dark ? .blue : .indigo)
                            .frame(width: 100, height: 100)
                            .glassEffect(.regular, in: .circle)
                            .padding(.top, 16)

                        // Title and Subtitle
                        VStack(spacing: 8) {
                            Text(content.title)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text(content.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }

                // Features Section
                Section("Features") {
                    ForEach(content.features, id: \.title) { feature in
                        InfoSheetRow(
                            symbol: feature.symbol,
                            title: feature.title,
                            description: feature.description
                        )
                    }
                }

                // Technologies Section
                Section("Technologies") {
                    ForEach(content.technologies, id: \.title) { tech in
                        InfoSheetRow(
                            symbol: tech.symbol,
                            title: tech.title,
                            description: tech.description
                        )
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
