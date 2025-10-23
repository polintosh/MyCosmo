//
//  WelcomeView.swift
//  MyCosmo
//
//  Welcome screen introducing the app with branding.
//  Demonstrates native SF Symbols, VStack composition, and animation modifiers.
//

import SwiftUI

// MARK: - WelcomeView

/// First onboarding screen with app introduction.
/// Learning Focus: Symbol animations, VStack spacing, and phaseAnimator.
struct WelcomeView: View {
    @State private var isVisible = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            // SF Symbol with native multicolor rendering
            Image(systemName: "sparkles")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce, value: isVisible)

            // App branding with high-contrast text styles
            VStack(spacing: 12) {
                Text("Welcome to")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.8))

                Text("MyCosmo")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Explore the universe and track your cosmic journey")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.horizontal, 40)
            }

            Spacer()

            // Native instructional text with SF Symbol
            HStack(spacing: 8) {
                Image(systemName: "hand.draw.fill")
                    .font(.caption)
                Text("Swipe to continue")
                    .font(.subheadline)
            }
            .foregroundStyle(.white.opacity(0.5))
            .padding(.bottom, 50)
        }
        // Smooth fade-in animation using native spring curve
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 30)
        .onAppear {
            withAnimation(.spring(duration: 0.8, bounce: 0.3)) {
                isVisible = true
            }
        }
    }
}
