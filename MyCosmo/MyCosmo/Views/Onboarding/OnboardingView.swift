//
//  OnboardingView.swift
//  MyCosmo
//
//  Main container for the onboarding experience.
//  Demonstrates TabView with PageTabViewStyle for native page-based navigation.
//

import SwiftUI

// MARK: - OnboardingView

/// Container view managing the onboarding flow with native paging.
/// Learning Focus: TabView with PageTabViewStyle for horizontal scrolling.
struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        // TabView provides native page-based navigation with swipe gestures
        TabView {
            WelcomeView()
            FeaturesView()
            ThanksView(completeOnboarding: {
                withAnimation(.easeInOut) {
                    hasCompletedOnboarding = true
                }
            })
        }
        // PageTabViewStyle enables horizontal paging with dots indicator
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .background {
            // Native gradient background with cosmic theme
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.06, blue: 0.17),
                    Color(red: 0.1, green: 0.12, blue: 0.35)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}
