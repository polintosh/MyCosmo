//
//  FeaturesView.swift
//  MyCosmo
//
//  Features overview showcasing app capabilities.
//  Demonstrates ViewBuilder pattern for reusable components.
//

import SwiftUI

// MARK: - FeaturesView

/// Second onboarding screen displaying app features.
/// Learning Focus: ViewBuilder for reusable components, minimal elegant design.
struct FeaturesView: View {
    @State private var isVisible = false

    var body: some View {
        VStack(spacing: 32) {
            // Header
            VStack(spacing: 8) {
                Text("What You'll Discover")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("Learn astronomy through exploration")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(.top, 60)

            // Feature cards with ViewBuilder
            VStack(spacing: 20) {
                spaceNewsFeature
                solarSystemFeature
                observationsFeature
            }
            .padding(.horizontal, 24)

            Spacer()

            // Swipe instruction
            HStack(spacing: 8) {
                Image(systemName: "hand.draw.fill")
                    .font(.caption)
                Text("Swipe to continue")
                    .font(.subheadline)
            }
            .foregroundStyle(.white.opacity(0.5))
            .padding(.bottom, 50)
        }
        .opacity(isVisible ? 1 : 0)
        .offset(x: isVisible ? 0 : 50)
        .onAppear {
            withAnimation(.spring(duration: 0.7, bounce: 0.3).delay(0.1)) {
                isVisible = true
            }
        }
    }

    // MARK: - Feature ViewBuilders

    /// Space News feature card with minimal design
    @ViewBuilder
    private var spaceNewsFeature: some View {
        HStack(spacing: 16) {
            // Icon with gradient background
            ZStack {
                Circle()
                    .fill(.orange.opacity(0.2))
                    .frame(width: 56, height: 56)

                Image(systemName: "photo.on.rectangle.angled")
                    .font(.title2)
                    .foregroundStyle(.orange)
            }

            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text("Space News")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Daily cosmic photography & news")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            Spacer()
        }
        .padding(16)
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    /// Solar System feature card with minimal design
    @ViewBuilder
    private var solarSystemFeature: some View {
        HStack(spacing: 16) {
            // Icon with gradient background
            ZStack {
                Circle()
                    .fill(.blue.opacity(0.2))
                    .frame(width: 56, height: 56)

                Image(systemName: "globe.americas.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
            }

            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text("Solar System")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Explore planets & celestial bodies")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            Spacer()
        }
        .padding(16)
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    /// Observations feature card with minimal design
    @ViewBuilder
    private var observationsFeature: some View {
        HStack(spacing: 16) {
            // Icon with gradient background
            ZStack {
                Circle()
                    .fill(.purple.opacity(0.2))
                    .frame(width: 56, height: 56)

                Image(systemName: "binoculars.fill")
                    .font(.title2)
                    .foregroundStyle(.purple)
            }

            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text("Observations")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Track your sky discoveries")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            Spacer()
        }
        .padding(16)
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
