//
//  UserObservationTests.swift
//  MyCosmoTests
//
//  Tests for UserObservation's displayPlanet logic - the "Other" planet
//  case falls back to a custom name, which is worth locking in.
//

import Testing

@testable import MyCosmo

struct UserObservationTests {

    @Test func displayPlanetReturnsRawValueForKnownPlanet() {
        let observation = UserObservation(
            title: "Test",
            description: "Test description",
            selectedPlanet: .mars,
            category: .astronomical,
            importance: .medium
        )
        #expect(observation.displayPlanet == "Mars")
    }

    @Test func displayPlanetUsesCustomNameForOther() {
        let observation = UserObservation(
            title: "Test",
            description: "Test description",
            selectedPlanet: .other,
            customPlanet: "Alpha Centauri",
            category: .astronomical,
            importance: .medium
        )
        #expect(observation.displayPlanet == "Alpha Centauri")
    }

    @Test func displayPlanetFallsBackToUnknownWhenOtherHasNoCustomName() {
        let observation = UserObservation(
            title: "Test",
            description: "Test description",
            selectedPlanet: .other,
            category: .astronomical,
            importance: .medium
        )
        #expect(observation.displayPlanet == "Unknown")
    }
}
