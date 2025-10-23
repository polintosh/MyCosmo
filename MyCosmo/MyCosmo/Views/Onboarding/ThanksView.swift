//
//  ThanksView.swift
//  MyCosmo
//
//  Final onboarding screen with completion action.
//  Demonstrates native button styles and elegant credit display.
//

import SwiftUI

// MARK: - ThanksView

/// Final onboarding screen with call-to-action.
/// Learning Focus: Native button styles, refined animations, and aesthetic layouts.
struct ThanksView: View {
    let completeOnboarding: () -> Void
    @State private var isVisible = false
    @State private var isPulsing = false

    var body: some View {
        VStack(spacing: 36) {
            Spacer()

            // Animated icon using valid SF Symbol
            Image(systemName: "sparkles")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.orange, .pink, .yellow)
                .scaleEffect(isPulsing ? 1.15 : 1.0)
                .animation(
                    .easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                    value: isPulsing
                )

            // Completion message
            VStack(spacing: 12) {
                Text("You're All Set!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("Ready to explore the cosmos")
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.75))
            }

            Spacer()

            // Elegant data sources display
            VStack(spacing: 16) {
                Text("Powered by")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.5))
                    .textCase(.uppercase)
                    .tracking(1.2)

                HStack(spacing: 12) {
                    dataSourceBadge(
                        icon: "photo.fill",
                        name: "NASA APOD",
                        color: .orange
                    )

                    dataSourceBadge(
                        icon: "newspaper.fill",
                        name: "Spaceflight News",
                        color: .blue
                    )
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)

            // Native prominent button
            Button(action: completeOnboarding) {
                HStack(spacing: 8) {
                    Text("Start Exploring")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.white)
            .foregroundStyle(.black)
            .padding(.horizontal, 32)
            .padding(.bottom, 60)
        }
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 40)
        .onAppear {
            withAnimation(.spring(duration: 0.8, bounce: 0.4).delay(0.2)) {
                isVisible = true
            }
            isPulsing = true
        }
    }

    // MARK: - ViewBuilder for Data Source Badge

    /// Creates a minimal, elegant badge for data sources
    @ViewBuilder
    private func dataSourceBadge(icon: String, name: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(color)

            Text(name)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(.white.opacity(0.1))
                .overlay(
                    Capsule()
                        .stroke(.white.opacity(0.2), lineWidth: 0.5)
                )
        )
    }
}
