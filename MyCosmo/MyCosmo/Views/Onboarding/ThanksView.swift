//
//  ThanksView.swift
//  MyCosmo
//
//  Final screen of the onboarding flow with completion action.
//  Demonstrates scale and spring animations, API credit attribution,
//  and closure-based completion handling to dismiss onboarding.
//
//  Key Features:
//  - Scale and fade animations for entrance effects
//  - API credit badges for data source attribution
//  - Spring animation for smooth transitions
//  - Completion closure to trigger app entry
//
//  Architecture: Final page in onboarding flow.
//

import SwiftUI

// MARK: - ThanksView

/// Final screen of onboarding thanking user and showing credits.
/// Uses spring animations and triggers completion to enter the app.
struct ThanksView: View {
    let completeOnboarding: () -> Void
    @State private var isAnimated = false

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            // Animated star icon
            Image(systemName: "sparkles")
                .font(.system(size: 80))
                .foregroundStyle(.white)
                .opacity(isAnimated ? 1 : 0)
                .scaleEffect(isAnimated ? 1 : 0.5)

            // Thank you message
            VStack(spacing: 16) {
                Text("Thank You!")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("Get ready to explore the wonders of our universe")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : 20)

            // API Credits
            VStack(spacing: 12) {
                Text("Powered by")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.6))

                HStack(spacing: 16) {
                    HStack(spacing: 8) {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                        Text("NASA APOD")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)

                    HStack(spacing: 8) {
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                        Text("NewsAPI")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
            .opacity(isAnimated ? 1 : 0)

            Spacer()

            // Start button
            Button(action: completeOnboarding) {
                Text("Start Exploring")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 24)
            .opacity(isAnimated ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(duration: 0.8)) {
                isAnimated = true
            }
        }
    }
}
