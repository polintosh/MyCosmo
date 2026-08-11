//
//  ObservationsViewModelTests.swift
//  MyCosmoTests
//
//  Tests ObservationsViewModel's delete operations against a real
//  in-memory SwiftData ModelContainer - the flagship SwiftData +
//  Swift Testing example for this project.
//

import SwiftData
import Testing

@testable import MyCosmo

@MainActor
struct ObservationsViewModelTests {

    /// Builds an in-memory SwiftData context so tests never touch the real on-disk store.
    private func makeInMemoryContext() throws -> ModelContext {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserObservation.self, configurations: config)
        return ModelContext(container)
    }

    @Test func deleteObservationRemovesItFromContext() throws {
        let context = try makeInMemoryContext()
        let observation = UserObservation(
            title: "Meteor Shower",
            description: "Saw a bright meteor.",
            selectedPlanet: .earth,
            category: .astronomical,
            importance: .high
        )
        context.insert(observation)

        let viewModel = ObservationsViewModel(modelContext: context)
        viewModel.deleteObservation(observation)

        let remaining = try context.fetch(FetchDescriptor<UserObservation>())
        #expect(remaining.isEmpty)
    }

    @Test func deleteObservationsAtOffsetsRemovesOnlySelected() throws {
        let context = try makeInMemoryContext()
        let keep = UserObservation(
            title: "Keep", description: "d", selectedPlanet: .mars,
            category: .astronomical, importance: .low)
        let remove = UserObservation(
            title: "Remove", description: "d", selectedPlanet: .venus,
            category: .astronomical, importance: .low)
        context.insert(keep)
        context.insert(remove)

        let viewModel = ObservationsViewModel(modelContext: context)
        viewModel.deleteObservations(at: IndexSet(integer: 1), from: [keep, remove])

        let remaining = try context.fetch(FetchDescriptor<UserObservation>())
        #expect(remaining.map(\.title) == ["Keep"])
    }
}
