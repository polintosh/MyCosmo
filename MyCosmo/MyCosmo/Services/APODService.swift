//
//  APODService.swift
//  MyCosmo
//
//  Service layer for fetching NASA's Astronomy Picture of the Day (APOD).
//  Uses Swift 6 async/await for modern asynchronous networking.
//  Handles API key management and rate limiting.
//
//  Architecture: Service layer in MVVM - consumed by ViewModels for data fetching.
//

import Foundation

// MARK: - APODService

/// Service for fetching NASA's APOD data using async/await networking.
///
/// Swift 6 Concurrency Design:
/// - Uses struct (not actor) since there's no mutable state to protect
/// - All methods are async and naturally thread-safe through Swift's async/await
/// - No isolation required - each call is independent and stateless
/// - URLSession.shared handles its own thread-safety internally
struct APODService {

    private let baseURL = "https://api.nasa.gov/planetary/apod"

    /// Fetches the Astronomy Picture of the Day from NASA's API
    ///
    /// Swift 6 Note: This method is naturally concurrency-safe because:
    /// - It's stateless (no shared mutable state)
    /// - URLSession.shared is already thread-safe
    /// - JSONDecoder is created fresh for each call (no sharing)
    /// - Return type (APODResponse) is Sendable, safe to pass across contexts
    ///
    /// - Returns: APODResponse containing image data and metadata
    /// - Throws: APIError.missingAPIKey if no API key found, URLError for network issues
    func fetchAPOD() async throws -> APODResponse {
        // Fetch API key from UserDefaults
        // UserDefaults is thread-safe and can be called from any context
        guard let apiKey = UserDefaults.standard.string(forKey: "nasaApiKey"), !apiKey.isEmpty
        else {
            throw APIError.missingAPIKey
        }

        // Build URL with query parameters
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        // Perform network request
        // URLSession.shared.data(from:) is inherently async and thread-safe
        let (data, response) = try await URLSession.shared.data(from: url)

        // Validate HTTP response
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }

        // Decode JSON response
        // Creating a new JSONDecoder for each call avoids any shared state issues
        // APODResponse is Sendable, so it's safe to decode and return across isolation boundaries
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.yyyyMMddFormatter)
        return try decoder.decode(APODResponse.self, from: data)
    }

    /// Date formatter for NASA's APOD API date format (YYYY-MM-DD)
    /// Static property is safe because DateFormatter is thread-safe for reading
    private static let yyyyMMddFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    /// Checks remaining API requests available for the current API key
    /// NASA's rate limit information is returned in HTTP headers
    ///
    /// Swift 6 Note: This method is thread-safe for the same reasons as fetchAPOD()
    /// - Returns: Number of remaining API calls, or nil if unavailable
    func getRemainingAPIRequests() async -> Int? {
        // Fetch API key from UserDefaults
        guard let apiKey = UserDefaults.standard.string(forKey: "nasaApiKey"), !apiKey.isEmpty
        else { return nil }

        // Build URL with query parameters
        var components = URLComponents(string: baseURL)!
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]

        guard let url = components.url else { return nil }

        do {
            // Perform network request to check rate limit headers
            let (_, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse,
                let remaining = httpResponse.value(forHTTPHeaderField: "X-RateLimit-Remaining")
            {
                return Int(remaining)
            }
        } catch {
            return nil
        }
        return nil
    }
}

// MARK: - API Errors

/// Custom errors for API operations
enum APIError: Error {
    case missingAPIKey
}
