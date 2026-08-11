//
//  SolarSystemServiceTests.swift
//  MyCosmoTests
//
//  Tests SolarSystemService's async fetch methods directly - it's an
//  actor over local data, so no mocking is needed, and it's a clean
//  example of writing Swift Testing tests against an actor.
//

import Testing

@testable import MyCosmo

struct SolarSystemServiceTests {

    @Test func fetchAllBodiesReturnsAllEightPlanets() async throws {
        let service = SolarSystemService()
        let planets = try await service.fetchAllBodies()
        #expect(planets.count == 8)
    }

    @Test func fetchPlanetDetailsReturnsEarthForKnownId() async throws {
        let service = SolarSystemService()
        let earth = try await service.fetchPlanetDetails(id: "399")
        #expect(earth.englishName == "Earth")
    }

    @Test func fetchPlanetDetailsThrowsForUnknownId() async {
        let service = SolarSystemService()
        await #expect(throws: (any Error).self) {
            _ = try await service.fetchPlanetDetails(id: "does-not-exist")
        }
    }
}
