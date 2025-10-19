//
//  APODResponse.swift
//  MyCosmo
//
//  Model representing NASA's Astronomy Picture of the Day (APOD) API response.
//  In MVVM architecture, this is a pure data model used by ViewModels to fetch
//  and process daily astronomy images from NASA's API.
//

import Foundation

// MARK: - APODResponse Model

/// Decodes NASA's APOD API JSON response into Swift properties.
/// Conforms to Codable for automatic JSON decoding from the API endpoint.
/// Marked as Sendable for safe concurrent access across actor boundaries.
struct APODResponse: Codable, Sendable {
    /// Date when the astronomy picture was featured (YYYY-MM-DD)
    let date: String

    /// Educational explanation of the astronomical phenomenon
    let explanation: String

    /// Optional high-definition image URL
    let hdurl: String?

    /// Media type: typically "image" or "video"
    let mediaType: String

    /// Title of the astronomy picture
    let title: String

    /// Standard resolution media URL
    let url: String

    /// Maps JSON snake_case keys to Swift camelCase properties
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case title
        case url
    }
}
