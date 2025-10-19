//
//  WelcomeView.swift
//  MyCosmo
//
//  First screen of the onboarding flow with animated entrance.
//  Demonstrates SwiftUI animations with opacity and offset modifiers.
//  Introduces the app with branding and call-to-action button.
//
//  Key Features:
//  - Fade-in and slide-up animations on appear
//  - Timed animation using withAnimation and easeOut
//  - Closure-based navigation to next page
//
//  Architecture: First page in onboarding flow.
//

import SwiftUI

// MARK: - WelcomeView

/// First screen of the onboarding experience with animated entrance.
/// Uses SwiftUI animations to create a polished welcome experience.
struct WelcomeView: View {
    let nextPage: () -> Void
    @State private var isAnimated = false

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            // App icon with fade-in
            Image("IconResource")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .opacity(isAnimated ? 1 : 0)

            // App title and tagline with slide-up animation
            VStack(spacing: 16) {
                Text("MyCosmo")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("Be your universe")
                    .font(.title2)
                    .italic()
                    .foregroundColor(.white.opacity(0.8))
            }
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : 20)

            Spacer()

            // Continue button
            Button(action: nextPage) {
                Text("Begin Your Journey")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 48)
            .opacity(isAnimated ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimated = true
            }
        }
    }
}
