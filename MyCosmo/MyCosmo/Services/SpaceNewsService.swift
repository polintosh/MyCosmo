//
//  SpaceNewsService.swift
//  MyCosmo
//
//  Service layer for fetching space-related news articles from external API.
//  Uses Spaceflight News API to retrieve articles, blogs, reports, and launch info.
//  Handles paginated responses and supports different content type filtering.
//
//  Architecture: Service layer in MVVM - provides news data to ViewModels via async/await.
//

import Foundation

// MARK: - SpaceNewsService

/// Service for fetching space news from Spaceflight News API.
///
/// Swift 6 Concurrency Design:
/// - Uses struct (not actor) since there's no mutable state to protect
/// - All methods are async and naturally thread-safe through Swift's async/await
/// - No isolation required - each call is independent and stateless
/// - URLSession.shared handles its own thread-safety internally
struct SpaceNewsService {

    private let baseURL = "https://api.spaceflightnewsapi.net/v4"

    /// Fetches space news articles based on type and limit
    ///
    /// Swift 6 Note: This method is naturally concurrency-safe because:
    /// - It's stateless (no shared mutable state)
    /// - URLSession.shared is already thread-safe
    /// - JSONDecoder is created fresh for each call (no sharing)
    /// - Return type ([SpaceNewsArticle]) contains Sendable elements, safe across contexts
    ///
    /// - Parameters:
    ///   - type: Category of news content (articles, blogs, reports, launches)
    ///   - limit: Maximum number of articles to retrieve (default: 20)
    /// - Returns: Array of SpaceNewsArticle objects
    /// - Throws: URLError for network or response issues
    func fetchNews(type: NewsType, limit: Int = 20) async throws -> [SpaceNewsArticle] {
        // Build URL with endpoint based on news type
        var components = URLComponents(
            string: "\(baseURL)/\(type.endpoint)")!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)")
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        // Perform network request
        // URLSession.shared.data(from:) is inherently async and thread-safe
        let (data, response) = try await URLSession.shared.data(from: url)

        // Validate HTTP response status code
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }

        // Decode JSON response
        // Creating a new JSONDecoder for each call avoids any shared state issues
        // SpaceNewsResponse and its contents are Sendable, safe to decode and return
        let decoder = JSONDecoder()
        let result = try decoder.decode(SpaceNewsResponse.self, from: data)
        return result.results
    }
}

// MARK: - API Response Container

/// Container for paginated response from Spaceflight News API.
/// API returns metadata for pagination alongside the actual article results.
///
/// Swift 6 Note: Marked as Sendable because:
/// - All properties are immutable (let)
/// - All property types are Sendable (Int, String?, [SpaceNewsArticle])
/// - SpaceNewsArticle is also Sendable
/// This makes it safe to pass across concurrency boundaries (async calls, Tasks, etc.)
struct SpaceNewsResponse: Codable, Sendable {
    /// Total number of available articles
    let count: Int
    /// URL for next page of results (nil if last page)
    let next: String?
    /// URL for previous page of results (nil if first page)
    let previous: String?
    /// Array of news articles in current page
    let results: [SpaceNewsArticle]
}
