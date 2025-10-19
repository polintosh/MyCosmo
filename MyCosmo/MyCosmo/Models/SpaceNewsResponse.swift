//
//  SpaceNewsResponse.swift
//  MyCosmo
//
//  Models for space news content from external news APIs.
//  Defines article structure and news category filtering.
//  Used by ViewModels to fetch and organize space-related news content.
//

import Foundation

// MARK: - SpaceNewsArticle Model

/// Represents a space news article from the Space News API.
/// Contains article metadata, content preview, and source information.
struct SpaceNewsArticle: Codable, Identifiable, Sendable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String

    /// Maps JSON snake_case keys to Swift camelCase properties
    enum CodingKeys: String, CodingKey {
        case id, title, url, summary
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - NewsType Enum

/// Categories for filtering space-related content.
/// Provides type-safe filtering with associated icons, colors, and API endpoints.
enum NewsType: String, CaseIterable, Sendable {
    case all = "All"
    case articles = "Articles"
    case blogs = "Blogs"
    case reports = "Reports"
    case launches = "Launches"

    /// SF Symbol icon for each news type
    nonisolated var icon: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .articles: return "newspaper.fill"
        case .blogs: return "text.book.closed.fill"
        case .reports: return "doc.text.fill"
        case .launches: return "paperplane"
        }
    }

    /// API endpoint path for each content type
    nonisolated var endpoint: String {
        switch self {
        case .all: return "articles"
        case .articles: return "articles"
        case .blogs: return "blogs"
        case .reports: return "reports"
        case .launches: return "launches"
        }
    }
}

// MARK: - NewsType UI Extension
// Note: Color property moved to View layer to avoid main-actor isolation in models
