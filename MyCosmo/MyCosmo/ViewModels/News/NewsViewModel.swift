//
//  NewsViewModel.swift
//  MyCosmo
//
//  ViewModel for managing space news and NASA's APOD content.
//  In MVVM architecture, this layer sits between Views and Services, handling business
//  logic and state management. Uses @MainActor to ensure all UI updates happen on the main thread.
//
//  Key Concepts:
//  - @MainActor: Ensures all properties and methods run on main thread for UI safety
//  - @Published: Properties that trigger SwiftUI view updates when changed
//  - ObservableObject: Protocol enabling SwiftUI's reactive data flow
//

import Combine
import Foundation
import SwiftUI

// MARK: - NewsViewModel

/// Manages state and data flow for space news and APOD features.
/// Coordinates between SpaceNewsService/APODService and the news views.
@MainActor
class NewsViewModel: ObservableObject {

    // MARK: - Published Properties

    /// NASA's Astronomy Picture of the Day data
    @Published var apodData: APODResponse?

    /// Error state for APOD fetching
    @Published var apodError: Error?

    /// Collection of space news articles
    @Published var newsArticles: [SpaceNewsArticle] = []

    /// Currently selected news category filter
    @Published var selectedNewsType: NewsType = .all

    /// Loading state indicator for UI feedback
    @Published var isLoading = false

    /// Error state for news fetching
    @Published var error: Error?

    // MARK: - Private Properties

    private let nasaService: APODService
    private let spaceNewsService: SpaceNewsService

    // MARK: - Initialization

    /// Initializes with dependency injection for testability
    init(
        nasaService: APODService = APODService(),
        spaceNewsService: SpaceNewsService = SpaceNewsService()
    ) {
        self.nasaService = nasaService
        self.spaceNewsService = spaceNewsService
    }

    // MARK: - Public Methods

    /// Fetches NASA's Astronomy Picture of the Day
    func fetchAPOD() async {
        isLoading = true
        do {
            apodError = nil
            apodData = try await nasaService.fetchAPOD()
        } catch {
            apodError = error
            apodData = nil
            print("Error fetching APOD: \(error)")
        }
        isLoading = false
    }

    /// Fetches space news articles based on selected category
    func fetchNews() async {
        isLoading = true
        do {
            error = nil
            newsArticles = try await spaceNewsService.fetchNews(type: selectedNewsType)
        } catch {
            self.error = error
            print("Error fetching news: \(error)")
        }
        isLoading = false
    }

    /// Changes news category and refreshes feed
    /// Tapping the same category twice reverts to showing all news
    func changeNewsType(_ type: NewsType) {
        if type == selectedNewsType {
            selectedNewsType = .all
        } else {
            selectedNewsType = type
        }
        Task {
            await fetchNews()
        }
    }
}
