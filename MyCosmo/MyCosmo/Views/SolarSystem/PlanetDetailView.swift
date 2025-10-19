//
//  PlanetDetailView.swift
//  MyCosmo
//
//  Detail view for displaying comprehensive planet information.
//  Demonstrates ScrollView with parallax effects, custom info cards,
//  and structured data presentation. Uses SwiftUI state management for dynamic content.
//
//  Key Features:
//  - Parallax header image effect
//  - Random fun facts with refresh capability
//  - Organized information sections with custom cards
//  - Conditional rendering based on available data
//
//  Architecture: Detail view in the Solar System feature.
//

import SwiftUI

// MARK: - PlanetDetailView

/// Detail view displaying comprehensive information about a specific planet.
/// Uses ScrollView with custom components for organized data presentation.
struct PlanetDetailView: View {
    let planet: PlanetData
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var currentFact: String
    @State private var scrollOffset: CGFloat = 0

    init(planet: PlanetData) {
        self.planet = planet
        self._currentFact = State(initialValue: planet.randomFunFact)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header Image with parallax effect
                Image(planet.englishName)
                    .resizable()
                    .scaledToFill()

                // Content
                VStack(spacing: 24) {
                    // Planet Name and Type
                    VStack(spacing: 4) {
                        Text(planet.englishName)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(planet.bodyType.capitalized)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top)

                    // Fun Fact Card
                    FunFactCard(currentFact: $currentFact, planet: planet)

                    // Quick Facts
                    QuickFactsSection(planet: planet)

                    // Detailed Info Sections
                    Group {
                        // Physical Characteristics
                        InfoCard(title: "Physical Characteristics") {
                            InfoRow(title: "Mean Radius", value: planet.formattedRadius)
                            InfoRow(title: "Gravity", value: planet.formattedGravity)
                            InfoRow(title: "Mass", value: planet.formattedMass)
                            InfoRow(
                                title: "Average Temperature", value: planet.formattedTemperature)
                            InfoRow(title: "Density", value: "\(Int(planet.density)) kg/m³")
                        }

                        // Orbital Characteristics
                        InfoCard(title: "Orbital Characteristics") {
                            InfoRow(title: "Axial Tilt", value: "\(Int(planet.axialTilt))°")
                            InfoRow(title: "Main Anomaly", value: "\(Int(planet.mainAnomaly))°")
                            InfoRow(
                                title: "Argument of Periapsis",
                                value: "\(Int(planet.argPeriapsis))°")
                        }

                        // Discovery Information (conditional)
                        if let discoveredBy = planet.discoveredBy,
                            let discoveryDate = planet.discoveryDate
                        {
                            InfoCard(title: "Discovery") {
                                InfoRow(title: "Discovered By", value: discoveredBy)
                                InfoRow(title: "Discovery Date", value: discoveryDate)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PlanetDetailView(
            planet: PlanetData(
                id: "399",
                name: "Earth",
                englishName: "Earth",
                isPlanet: true,
                moons: nil,
                gravity: 9.8,
                meanRadius: 6371.0,
                mass: .init(massValue: 5.972, massExponent: 24),
                vol: .init(volValue: 1.083, volExponent: 12),
                density: 5514,
                discoveredBy: nil,
                discoveryDate: nil,
                alternativeName: nil,
                axialTilt: 23.44,
                avgTemp: 288,
                mainAnomaly: 358.617,
                argPeriapsis: 114.207,
                longAscNode: 348.739,
                bodyType: "Planet",
                rel: "",
                funFacts: ["Earth is the only known planet with life."]
            ))
    }
}
