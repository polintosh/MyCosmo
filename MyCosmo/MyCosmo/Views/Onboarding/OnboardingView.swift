//
//  OnboardingView.swift
//  MyCosmo
//
//  Main container for the app's onboarding experience flow.
//  Manages page transitions and completion state using SwiftUI state management.
//  Demonstrates custom background gradients and page-based navigation.
//
//  Key Features:
//  - State-driven page navigation
//  - Smooth transitions between onboarding screens
//  - Binding to parent view for completion tracking
//  - Custom gradient background for branded experience
//
//  Architecture: Container view managing onboarding flow state.
//

import SwiftUI

// MARK: - OnboardingView

/// Container view managing the onboarding experience flow.
/// Uses state to track current page and binding to signal completion.
struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 13 / 255, green: 15 / 255, blue: 44 / 255),
                    Color(red: 26 / 255, green: 30 / 255, blue: 88 / 255),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Page content with transitions
            Group {
                switch currentPage {
                case 0:
                    WelcomeView(nextPage: { currentPage = 1 })
                case 1:
                    FeaturesView(nextPage: { currentPage = 2 })
                case 2:
                    ThanksView(
                        completeOnboarding: {
                            withAnimation {
                                hasCompletedOnboarding = true
                            }
                        })
                default:
                    EmptyView()
                }
            }
            .transition(.opacity)
        }
        .preferredColorScheme(.dark)
    }
}
