//
//  ObservationDetailViewModel.swift
//  MyCosmo
//
//  ViewModel for managing a single astronomical observation's detail view.
//  Handles display formatting and deletion operations with SwiftData persistence.
//  Uses @MainActor to ensure UI updates occur on the main thread.
//
//  Architecture: Connects observation detail views with SwiftData's ModelContext.
//  Uses @Observable (not ObservableObject/@Published) so SwiftUI observes property changes automatically.
//

import SwiftData
import SwiftUI

// MARK: - ObservationDetailViewModel

/// Manages state and actions for displaying and editing a single observation.
/// Provides formatted data for views and handles deletion logic.
@MainActor
@Observable
class ObservationDetailViewModel {

    // MARK: - Properties

    /// The observation being displayed
    let observation: UserObservation

    /// Controls visibility of delete confirmation alert
    var showDeleteAlert = false

    /// Triggers dismissal of detail view after deletion
    var shouldDismiss = false

    /// SwiftData context for persistence operations
    private let modelContext: ModelContext

    // MARK: - Initialization

    /// Initializes with the observation to manage
    init(observation: UserObservation) {
        self.observation = observation
        self.modelContext = observation.modelContext!
    }

    // MARK: - Computed Properties

    /// Formats the observation date for display
    var formattedDate: String {
        observation.date.formatted(date: .abbreviated, time: .omitted)
    }

    // MARK: - Methods

    /// Deletes the observation from SwiftData and triggers view dismissal
    func deleteObservation() {
        modelContext.delete(observation)
        shouldDismiss = true
    }
}
