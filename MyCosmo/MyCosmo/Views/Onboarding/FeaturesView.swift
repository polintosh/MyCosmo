//
//  FeaturesView.swift
//  MyCosmo
//
//  Second screen of the onboarding flow showcasing app features.
//  Demonstrates expandable cards with spring animations and state management.
//  Uses interactive buttons with animated chevron indicators.
//
//  Key Features:
//  - Expandable feature cards with spring animations
//  - Staggered entrance animations on appear
//  - State management for card expansion
//  - Custom Feature model for structured data
//
//  Architecture: Second page in onboarding flow.
//

import SwiftUI

// MARK: - FeaturesView

/// Second screen of onboarding displaying app features with expandable cards.
/// Uses animations and interactive elements to showcase functionality.
struct FeaturesView: View {
    let nextPage: () -> Void
    @State private var isAnimated = false
    @State private var selectedFeatureId: UUID?

    private let features = [
        Feature(
            title: "Space News",
            icon: "newspaper.fill",
            color: .blue,
            description:
                "Stay updated with the latest astronomy news and NASA's Astronomy Picture of the Day"
        ),
        Feature(
            title: "Solar System",
            icon: "globe.americas.fill",
            color: .purple,
            description:
                "Explore detailed information about planets, moons, and other objects in our Solar System"
        ),
        Feature(
            title: "Observations",
            icon: "binoculars.fill",
            color: .teal,
            description: "Record and track your astronomical observations and discoveries"
        ),
    ]

    var body: some View {
        VStack(spacing: 40) {
            Text("Features")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.top, 60)
                .opacity(isAnimated ? 1 : 0)

            // Feature Cards
            VStack(spacing: 24) {
                ForEach(features) { feature in
                    FeatureRow(feature: feature, selectedFeatureId: $selectedFeatureId)
                        .opacity(isAnimated ? 1 : 0)
                        .offset(x: isAnimated ? 0 : -50)
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            Button(action: nextPage) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 48)
            .opacity(isAnimated ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimated = true
            }
        }
    }
}

// MARK: - Feature Model

/// Model representing an app feature displayed in onboarding.
/// Contains display information and description for each feature.
struct Feature: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let description: String
}

// MARK: - FeatureRow

/// Expandable row view for displaying a feature with animation.
/// Tapping toggles the visibility of the feature description.
struct FeatureRow: View {
    let feature: Feature
    @Binding var selectedFeatureId: UUID?

    private var isExpanded: Bool {
        selectedFeatureId == feature.id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                withAnimation(.spring()) {
                    selectedFeatureId = isExpanded ? nil : feature.id
                }
            }) {
                HStack(spacing: 20) {
                    Image(systemName: feature.icon)
                        .font(.system(size: 30))
                        .foregroundStyle(feature.color)
                        .frame(width: 60, height: 60)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())

                    Text(feature.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.white.opacity(0.6))
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
            }

            if isExpanded {
                Text(feature.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.leading, 80)
                    .padding(.trailing, 20)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
}
