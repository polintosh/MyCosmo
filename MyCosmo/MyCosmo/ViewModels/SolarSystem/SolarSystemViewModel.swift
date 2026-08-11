//
//  SolarSystemViewModel.swift
//  MyCosmo
//
//  ViewModel for managing solar system exploration and planet data.
//  Handles fetching planet information from local service and manages selection state.
//  Uses async/await for data operations and @MainActor for thread-safe UI updates.
//
//  Architecture: Coordinates between SolarSystemService and solar system views in MVVM pattern.
//  Uses @Observable (not ObservableObject/@Published) so SwiftUI observes property changes automatically.
//

import Foundation

// MARK: - SolarSystemViewModel

/// Manages state and data flow for solar system exploration features.
/// Fetches planet data from service layer and maintains selected planet state.
@MainActor
@Observable
class SolarSystemViewModel {

    // MARK: - Observable Properties

    /// Array of all planets in the solar system
    var planets: [PlanetData] = []

    /// Currently selected planet for detailed view
    var selectedPlanet: PlanetData?

    /// Loading state indicator for UI feedback
    var isLoading = false

    /// Error state for handling fetch failures
    var error: Error?

    // MARK: - Private Properties

    private let service: SolarSystemService

    // MARK: - Initialization

    /// Initializes with dependency injection for testability
    init(service: SolarSystemService = SolarSystemService()) {
        self.service = service
    }

    // MARK: - Methods

    /// Fetches all planets in the solar system from service
    func fetchPlanets() async {
        isLoading = true
        do {
            planets = try await service.fetchAllBodies()
        } catch {
            self.error = error
            print("Error fetching planets: \(error)")
        }
        isLoading = false
    }

    /// Fetches detailed information for a specific planet
    func fetchPlanetDetails(id: String) async {
        isLoading = true
        do {
            selectedPlanet = try await service.fetchPlanetDetails(id: id)
        } catch {
            self.error = error
            print("Error fetching planet details: \(error)")
        }
        isLoading = false
    }
}
