//
//  UserObservation.swift
//  MyCosmo
//
//  SwiftData model for storing user-recorded astronomical observations.
//  Persists observation details including images, metadata, and categorization.
//  Used throughout the app to track and display user's astronomy discoveries.
//

import SwiftData
import SwiftUI

// MARK: - UserObservation Model

/// Represents a user's astronomical observation stored in SwiftData.
/// Decorated with @Model to enable persistent storage and automatic change tracking.
@Model
final class UserObservation {
    var title: String
    var observationDescription: String
    var selectedPlanet: Planet
    var customPlanet: String?
    var category: ObservationCategory
    var importance: ImportanceLevel
    var date: Date
    var customImage: Data?
    var additionalImages: [Data]?

    /// Returns the planet name, using custom name when planet is "Other"
    var displayPlanet: String {
        if selectedPlanet == .other {
            return customPlanet ?? "Unknown"
        }
        return selectedPlanet.rawValue
    }

    /// Returns user's image or default planet image as fallback
    var displayImage: Image {
        if let imageData = customImage,
            let uiImage = UIImage(data: imageData)
        {
            return Image(uiImage: uiImage)
        }
        return selectedPlanet.defaultImage
    }

    init(
        title: String,
        description: String,
        selectedPlanet: Planet,
        customPlanet: String? = nil,
        category: ObservationCategory,
        importance: ImportanceLevel,
        date: Date = Date(),
        customImage: Data? = nil,
        additionalImages: [Data]? = nil
    ) {
        self.title = title
        self.observationDescription = description
        self.selectedPlanet = selectedPlanet
        self.customPlanet = customPlanet
        self.category = category
        self.importance = importance
        self.date = date
        self.customImage = customImage
        self.additionalImages = additionalImages
    }
}

// MARK: - Supporting Enums

/// Categories for classifying astronomical observations
enum ObservationCategory: String, Codable, CaseIterable, Sendable {
    case atmospheric = "Atmospheric"
    case geological = "Geological"
    case astronomical = "Astronomical"
    case other = "Other"
}

/// Priority levels for observations
enum ImportanceLevel: String, Codable, CaseIterable, Sendable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case critical = "Critical"
}

/// Celestial bodies available for observation
enum Planet: String, Codable, CaseIterable, Sendable {
    case mercury = "Mercury"
    case venus = "Venus"
    case earth = "Earth"
    case mars = "Mars"
    case jupiter = "Jupiter"
    case saturn = "Saturn"
    case uranus = "Uranus"
    case neptune = "Neptune"
    case other = "Other"

    /// Returns default image asset for each planet
    nonisolated var defaultImage: Image {
        Image(rawValue)
    }
}
