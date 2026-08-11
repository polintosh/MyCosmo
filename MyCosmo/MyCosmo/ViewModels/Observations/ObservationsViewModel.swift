//
//  ObservationsViewModel.swift
//  MyCosmo
//
//  ViewModel for managing the list of user's astronomical observations.
//  Handles observation collection display, creation flow, and deletion operations.
//  Integrates with SwiftData for persistent storage of observations.
//
//  Architecture: Mediates between observation list views and SwiftData's ModelContext.
//  Uses @Observable (not ObservableObject/@Published) so SwiftUI observes property changes automatically.
//

import SwiftData
import SwiftUI

// MARK: - ObservationsViewModel

/// Manages state and operations for the observations list view.
/// Coordinates observation creation, deletion, and persistence through SwiftData.
@MainActor
@Observable
class ObservationsViewModel {

    // MARK: - Observable Properties

    /// Controls visibility of the add observation sheet
    var showingAddSheet = false

    // MARK: - Properties

    /// SwiftData context for persistence operations
    let modelContext: ModelContext

    // MARK: - Initialization

    /// Initializes with SwiftData context for managing observations
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Methods

    /// Deletes a single observation from SwiftData
    func deleteObservation(_ observation: UserObservation) {
        modelContext.delete(observation)
    }

    /// Deletes multiple observations at specified indices
    /// Used for swipe-to-delete actions in list views
    func deleteObservations(at offsets: IndexSet, from observations: [UserObservation]) {
        for index in offsets {
            modelContext.delete(observations[index])
        }
    }
}
