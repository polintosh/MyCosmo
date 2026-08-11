//
//  ObservationDetailViewModelTests.swift
//  MyCosmoTests
//
//  Tests ObservationDetailViewModel against an in-memory SwiftData context.
//

import SwiftData
import Testing

@testable import MyCosmo

@MainActor
struct ObservationDetailViewModelTests {

    private func makeInMemoryContext() throws -> ModelContext {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserObservation.self, configurations: config)
        return ModelContext(container)
    }

    @Test func deleteObservationRemovesItAndSetsShouldDismiss() throws {
        let context = try makeInMemoryContext()
        let observation = UserObservation(
            title: "Solar Eclipse",
            description: "Total eclipse.",
            selectedPlanet: .earth,
            category: .astronomical,
            importance: .critical
        )
        // Must insert before constructing the view model - its init force-unwraps
        // observation.modelContext, so an un-inserted observation would crash here.
        context.insert(observation)

        let viewModel = ObservationDetailViewModel(observation: observation)
        viewModel.deleteObservation()

        #expect(viewModel.shouldDismiss == true)
        let remaining = try context.fetch(FetchDescriptor<UserObservation>())
        #expect(remaining.isEmpty)
    }

    @Test func formattedDateUsesAbbreviatedStyle() throws {
        let context = try makeInMemoryContext()
        let fixedDate = Date(timeIntervalSince1970: 1_700_000_000)
        let observation = UserObservation(
            title: "Test",
            description: "d",
            selectedPlanet: .earth,
            category: .astronomical,
            importance: .low,
            date: fixedDate
        )
        context.insert(observation)

        let viewModel = ObservationDetailViewModel(observation: observation)
        #expect(viewModel.formattedDate == fixedDate.formatted(date: .abbreviated, time: .omitted))
    }
}
