//
//  ObservationsView.swift
//  MyCosmo
//
//  Main view for displaying and managing user's astronomical observations.
//  Demonstrates SwiftUI's @Query macro for SwiftData integration, filtering logic,
//  and ContentUnavailableView for empty states. Uses MVVM with ObservationsViewModel.
//
//  Key Features:
//  - @Query macro for reactive SwiftData queries
//  - Multi-criteria filtering (category, importance, planet)
//  - ContentUnavailableView for empty state handling
//  - Sheet presentation for adding new observations
//  - Info sheet with app feature explanations
//
//  Architecture: View layer consuming ObservationsViewModel and SwiftData in MVVM pattern.
//

import PhotosUI
import SwiftData
import SwiftUI

// MARK: - ObservationsView

/// Main view for displaying and managing astronomical observations.
/// Uses SwiftData's @Query for automatic data fetching and updates.
struct ObservationsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var observations: [UserObservation]
    @StateObject private var viewModel: ObservationsViewModel

    @State private var selectedCategory: ObservationCategory?
    @State private var selectedImportance: ImportanceLevel?
    @State private var selectedPlanet: Planet?
    @State private var showingFilters = false
    @State private var showingInfo = false

    init() {
        let context = try! ModelContainer(for: UserObservation.self).mainContext
        _viewModel = StateObject(wrappedValue: ObservationsViewModel(modelContext: context))
    }

    /// Filters observations based on selected criteria
    var filteredObservations: [UserObservation] {
        observations.filter { observation in
            let categoryMatch = selectedCategory == nil || observation.category == selectedCategory
            let importanceMatch =
                selectedImportance == nil || observation.importance == selectedImportance
            let planetMatch = selectedPlanet == nil || observation.selectedPlanet == selectedPlanet
            return categoryMatch && importanceMatch && planetMatch
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredObservations.isEmpty {
                    ContentUnavailableView {
                        Label("No Observations", systemImage: "sparkle.magnifyingglass")
                    } description: {
                        Text("Start recording your astronomical observations")
                    }
                } else {
                    List {
                        ForEach(filteredObservations) { observation in
                            NavigationLink(
                                destination: ObservationDetailView(observation: observation)
                            ) {
                                ObservationRowView(observation: observation)
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.deleteObservations(at: indexSet, from: filteredObservations)
                        }
                    }
                }
            }
            .navigationTitle("Observations")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            showingFilters = true
                        } label: {
                            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                        }

                        Button {
                            selectedCategory = nil
                            selectedImportance = nil
                            selectedPlanet = nil
                        } label: {
                            Label("Clear Filters", systemImage: "xmark.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.showingAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddSheet) {
                AddObservationView()
            }
            .sheet(isPresented: $showingFilters) {
                NavigationStack {
                    Form {
                        Section("Category") {
                            Picker("Category", selection: $selectedCategory) {
                                Text("All").tag(nil as ObservationCategory?)
                                ForEach(ObservationCategory.allCases, id: \.self) { category in
                                    Text(category.rawValue).tag(category as ObservationCategory?)
                                }
                            }
                            .pickerStyle(.inline)
                            .labelsHidden()
                        }

                        Section("Importance") {
                            Picker("Importance", selection: $selectedImportance) {
                                Text("All").tag(nil as ImportanceLevel?)
                                ForEach(ImportanceLevel.allCases, id: \.self) { level in
                                    Text(level.rawValue).tag(level as ImportanceLevel?)
                                }
                            }
                            .pickerStyle(.inline)
                            .labelsHidden()
                        }

                        Section("Planet") {
                            Picker("Planet", selection: $selectedPlanet) {
                                Text("All").tag(nil as Planet?)
                                ForEach(Planet.allCases, id: \.self) { planet in
                                    Text(planet.rawValue).tag(planet as Planet?)
                                }
                            }
                            .pickerStyle(.inline)
                            .labelsHidden()
                        }
                    }
                    .navigationTitle("Filters")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showingFilters = false
                            }
                        }
                    }
                }
                .presentationDetents([.medium])
            }
            .sheet(isPresented: $showingInfo) {
                InfoSheet(content: infoContent)
            }
        }
    }

    private let infoContent = InfoSheetContent(
        icon: "binoculars.fill",
        title: "Observations",
        subtitle:
            "Record and track your astronomical observations with photos, notes, and detailed metadata.",
        features: [
            (
                symbol: "camera.fill", title: "Photo Capture",
                description: "Add photos to document your observations"
            ),
            (
                symbol: "text.alignleft", title: "Detailed Notes",
                description: "Record descriptions and findings"
            ),
            (
                symbol: "line.3.horizontal.decrease.circle", title: "Filtering",
                description: "Filter by category, importance, or planet"
            ),
        ],
        technologies: [
            (
                symbol: "swift", title: "Swift Features",
                description: "SwiftData, @Query macro, PhotosUI integration"
            ),
            (
                symbol: "cylinder.fill", title: "Data Persistence",
                description: "SwiftData for local storage and syncing"
            ),
        ]
    )
}

// MARK: - ObservationRowView

/// Row view for displaying an observation in a list.
/// Shows observation image, title, planet, and importance badge.
struct ObservationRowView: View {
    let observation: UserObservation

    var body: some View {
        HStack(spacing: 12) {
            observation.displayImage
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(observation.title)
                    .font(.headline)

                HStack(spacing: 8) {
                    Text(observation.displayPlanet)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Text(observation.category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            ImportanceBadge(importance: observation.importance)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - ImportanceBadge

/// Badge view for displaying observation importance level.
/// Uses color coding to indicate priority.
struct ImportanceBadge: View {
    let importance: ImportanceLevel

    var badgeColor: Color {
        switch importance {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }

    var body: some View {
        Text(importance.rawValue)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(badgeColor)
            .clipShape(Capsule())
    }
}
