//
//  MyCosmoApp.swift
//  MyCosmo
//
//  App entry point. Builds the SwiftData ModelContainer and routes to
//  onboarding on first launch, otherwise the main tab interface.
//
//  Architecture: Composition root - wires SwiftData and app-wide
//  preferences (@AppStorage) into the view hierarchy.
//

import SwiftUI
import SwiftData

// MARK: - MyCosmoApp

/// App entry point. Owns the SwiftData container and decides which
/// root view to show based on the persisted onboarding flag.
@main
struct MyCosmoApp: App {
    /// SwiftData container for UserObservation persistence, shared app-wide via .modelContainer(_:).
    let container: ModelContainer
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("appearanceMode") private var appearanceMode = 0 // 0: system, 1: light, 2: dark

    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: UserObservation.self, configurations: config)
        } catch {
            // No safe fallback if the on-disk store can't be opened (e.g. corrupted
            // or incompatible schema) - fail fast rather than run without persistence.
            fatalError("Could not configure container")
        }
    }

    var body: some Scene {
        WindowGroup {
            if !hasCompletedOnboarding {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .preferredColorScheme(colorScheme)
            } else {
                MainTabView()
                    .preferredColorScheme(colorScheme)
            }
        }
        .modelContainer(container)
    }

    /// Maps the stored appearance preference to a SwiftUI ColorScheme override.
    private var colorScheme: ColorScheme? {
        switch appearanceMode {
        case 1: return .light
        case 2: return .dark
        default: return nil
        }
    }
}
