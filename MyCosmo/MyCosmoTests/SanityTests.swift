//
//  SanityTests.swift
//  MyCosmoTests
//
//  Confirms the MyCosmoTests target/scheme are wired correctly before
//  relying on the real test suite. If this fails to discover or run,
//  the problem is in the project setup, not the app code.
//

import Testing

@testable import MyCosmo

@Test func sanityCheckTargetIsWired() {
    #expect(1 + 1 == 2)
}
