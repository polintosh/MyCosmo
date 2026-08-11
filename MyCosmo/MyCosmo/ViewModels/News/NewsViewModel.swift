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
//  - @Observable: Macro that makes SwiftUI observe property changes automatically,
//    without needing @Published on each one (the ObservableObject-era pattern)
//

import Foundation
import SwiftUI

// MARK: - NewsViewModel

/// Manages state and data flow for space news and APOD features.
/// Coordinates between SpaceNewsService/APODService and the news views.
@MainActor
@Observable
class NewsViewModel {

    // MARK: - Observable Properties

    /// NASA's Astronomy Picture of the Day data
    var apodData: APODResponse?

    /// Error state for APOD fetching
    var apodError: Error?

    /// Collection of space news articles
    var newsArticles: [SpaceNewsArticle] = []

    /// Currently selected news category filter
    var selectedNewsType: NewsType = .all

    /// Loading state indicator for UI feedback
    var isLoading = false

    /// Error state for news fetching
    var error: Error?

    // MARK: - Private Properties

    private let nasaService: APODFetching
    private let spaceNewsService: SpaceNewsFetching

    // MARK: - Initialization

    /// Initializes with dependency injection for testability - defaults to the
    /// real services, but accepts mocks conforming to APODFetching/SpaceNewsFetching in tests
    init(
        nasaService: APODFetching = APODService(),
        spaceNewsService: SpaceNewsFetching = SpaceNewsService()
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
            newsArticles = try await spaceNewsService.fetchNews(type: selectedNewsType, limit: 20)
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
