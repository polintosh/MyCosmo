//
//  InfoSheetRow.swift
//  MyCosmo
//
//  Reusable row component for displaying information with icon, title, and description.
//  Uses SwiftUI's Label component for consistent icon-text layout.
//  Demonstrates component composition and reusability patterns.
//
//  Architecture: Reusable UI component in the View layer.
//

import SwiftUI

// MARK: - InfoSheetRow

/// Reusable row for displaying feature or technology information.
/// Combines SF Symbol icon with title and description in vertical layout.
struct InfoSheetRow: View {
    let symbol: String
    let title: String
    let description: String

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        } icon: {
            Image(systemName: symbol)
                .foregroundStyle(Color.accentColor)
                .font(.title3)
        }
        .padding(.vertical, 4)
    }
}
