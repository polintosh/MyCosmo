//
//  ObservationDetailViewModel.swift
//  MyCosmo
//
//  ViewModel for managing a single astronomical observation's detail view.
//  Handles display formatting and deletion operations with SwiftData persistence.
//  Uses @MainActor to ensure UI updates occur on the main thread.
//
//  Architecture: Connects observation detail views with SwiftData's ModelContext.
//

import Combine
import SwiftData
import SwiftUI

// MARK: - ObservationDetailViewModel

/// Manages state and actions for displaying and editing a single observation.
/// Provides formatted data for views and handles deletion logic.
@MainActor
class ObservationDetailViewModel: ObservableObject {

    // MARK: - Properties

    /// The observation being displayed
    let observation: UserObservation

    /// Controls visibility of delete confirmation alert
    @Published var showDeleteAlert = false

    /// Triggers dismissal of detail view after deletion
    @Published var shouldDismiss = false

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
