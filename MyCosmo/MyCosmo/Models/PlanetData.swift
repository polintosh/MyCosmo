//
//  PlanetData.swift
//  MyCosmo
//
//  Model representing detailed information about celestial bodies in the solar system.
//  Contains physical characteristics, orbital parameters, and metadata from API responses.
//  Includes computed properties for formatted display in views.
//

import Foundation

// MARK: - PlanetData Model

/// Represents a celestial body with its physical and orbital characteristics.
/// Decodes JSON from solar system API into structured Swift properties.
struct PlanetData: Codable, Identifiable {
    let id: String
    let name: String
    let englishName: String
    let isPlanet: Bool
    let moons: [Moon]?
    let gravity: Double
    let meanRadius: Double
    let mass: Mass
    let vol: Volume
    let density: Double
    let discoveredBy: String?
    let discoveryDate: String?
    let alternativeName: String?
    let axialTilt: Double
    let avgTemp: Double
    let mainAnomaly: Double
    let argPeriapsis: Double
    let longAscNode: Double
    let bodyType: String
    let rel: String
    let funFacts: [String]

    /// Represents a moon orbiting the celestial body
    struct Moon: Codable, Identifiable {
        var id: String { rel }
        let rel: String
    }

    /// Mass in scientific notation (value × 10^exponent)
    struct Mass: Codable {
        let massValue: Double
        let massExponent: Int
    }

    /// Volume in scientific notation (value × 10^exponent)
    struct Volume: Codable {
        let volValue: Double
        let volExponent: Int
    }

    // MARK: - Computed Properties

    var formattedRadius: String {
        "\(Int(meanRadius)) km"
    }

    var formattedTemperature: String {
        "\(Int(avgTemp))°K (\(Int(avgTemp - 273.15))°C)"
    }

    var formattedGravity: String {
        String(format: "%.2f m/s²", gravity)
    }

    var formattedMass: String {
        "\(massValue)×10^\(massExponent) kg"
    }

    private var massValue: String {
        String(format: "%.2f", mass.massValue)
    }

    private var massExponent: Int {
        mass.massExponent
    }

    var randomFunFact: String {
        funFacts.randomElement() ?? "No fun facts available"
    }
}

// MARK: - API Response Container

/// Container for API response containing multiple celestial bodies
struct PlanetResponse: Codable {
    let bodies: [PlanetData]
}
