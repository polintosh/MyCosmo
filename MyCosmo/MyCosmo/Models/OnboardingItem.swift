//
//  OnboardingItem.swift
//  MyCosmo
//
//  Models for the app's onboarding experience flow.
//  Defines onboarding page navigation and feature content structure.
//  Used by onboarding views to display welcome screens and feature highlights.
//

import Foundation
import SwiftUI

// MARK: - OnboardingPage Enum

/// Defines the pages in the onboarding flow.
/// Conforms to Identifiable for SwiftUI navigation and CaseIterable for iteration.
enum OnboardingPage: Identifiable, CaseIterable {
    case welcome
    case features
    case thanks

    var id: Self { self }
}

// MARK: - OnboardingItem Struct

/// Represents a feature highlight shown during onboarding.
/// Contains title, description, icon, and theme color for each feature card.
struct OnboardingItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let systemImage: String
    let tint: Color

    /// Predefined features displayed during onboarding
    static let features: [OnboardingItem] = [
        OnboardingItem(
            title: "Explore Your Home",
            description:
                "Stay updated with NASA's Picture of the Day and discover the wonders of our planet Earth.",
            systemImage: "globe.europe.africa.fill",
            tint: .blue
        ),
        OnboardingItem(
            title: "Journey Through Space",
            description:
                "Embark on an interactive tour of our Solar System, with detailed information about each celestial body.",
            systemImage: "sun.and.horizon.fill",
            tint: .orange
        ),
        OnboardingItem(
            title: "Record Your Discoveries",
            description:
                "Document your astronomical observations, from meteor showers to planetary alignments.",
            systemImage: "binoculars.fill",
            tint: .purple
        ),
    ]

    /// Data source acknowledgments
    static let credits = """
        Special thanks to:
        • NASA APIs
        • JPL Solar System Dynamics
        • Space Weather Database
        • EONET
        """
}
