//
//  PlanetDataTests.swift
//  MyCosmoTests
//
//  Tests for PlanetData's formatted display properties - pure computed
//  properties with no dependencies, a good first Swift Testing example.
//

import Testing

@testable import MyCosmo

struct PlanetDataTests {

    /// Builds a minimal Earth-like PlanetData for testing formatted properties.
    private func makeEarth(funFacts: [String] = ["Earth has one moon."]) -> PlanetData {
        PlanetData(
            id: "399",
            name: "Earth",
            englishName: "Earth",
            isPlanet: true,
            moons: [.init(rel: "Moon")],
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
            funFacts: funFacts
        )
    }

    @Test func formattedRadiusRoundsToWholeKilometers() {
        #expect(makeEarth().formattedRadius == "6371 km")
    }

    @Test func formattedTemperatureShowsKelvinAndCelsius() {
        #expect(makeEarth().formattedTemperature == "288°K (14°C)")
    }

    @Test func formattedGravityHasTwoDecimalPlaces() {
        #expect(makeEarth().formattedGravity == "9.80 m/s²")
    }

    @Test func formattedMassCombinesValueAndExponent() {
        #expect(makeEarth().formattedMass == "5.97×10^24 kg")
    }

    @Test func randomFunFactReturnsAKnownFact() {
        let facts = ["Fact A", "Fact B", "Fact C"]
        #expect(facts.contains(makeEarth(funFacts: facts).randomFunFact))
    }

    @Test func randomFunFactFallsBackWhenEmpty() {
        #expect(makeEarth(funFacts: []).randomFunFact == "No fun facts available")
    }
}
