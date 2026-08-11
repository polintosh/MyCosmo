//
//  NewsViewModelTests.swift
//  MyCosmoTests
//
//  Tests NewsViewModel fully offline using APODFetching/SpaceNewsFetching
//  mocks - demonstrates protocol-based dependency injection for testing
//  code that would otherwise hit a live network API.
//

import Testing

@testable import MyCosmo

@MainActor
struct NewsViewModelTests {

    private struct MockAPODService: APODFetching {
        var result: Result<APODResponse, APIError>

        func fetchAPOD() async throws -> APODResponse {
            try result.get()
        }
    }

    private struct MockSpaceNewsService: SpaceNewsFetching {
        var articles: [SpaceNewsArticle]

        func fetchNews(type: NewsType, limit: Int) async throws -> [SpaceNewsArticle] {
            articles
        }
    }

    private static func makeArticle(id: Int, title: String) -> SpaceNewsArticle {
        SpaceNewsArticle(
            id: id,
            title: title,
            url: "https://example.com/\(id)",
            imageUrl: "https://example.com/\(id).jpg",
            newsSite: "Test Site",
            summary: "Summary",
            publishedAt: "2024-01-01T00:00:00.000Z",
            updatedAt: "2024-01-01T00:00:00.000Z"
        )
    }

    @Test func fetchNewsPopulatesArticlesFromMock() async {
        let articles = [
            Self.makeArticle(id: 1, title: "First"),
            Self.makeArticle(id: 2, title: "Second"),
        ]
        let viewModel = NewsViewModel(
            nasaService: MockAPODService(result: .failure(.missingAPIKey)),
            spaceNewsService: MockSpaceNewsService(articles: articles)
        )

        await viewModel.fetchNews()

        #expect(viewModel.newsArticles.map(\.title) == ["First", "Second"])
    }

    @Test func fetchAPODSurfacesServiceError() async {
        let viewModel = NewsViewModel(
            nasaService: MockAPODService(result: .failure(.missingAPIKey)),
            spaceNewsService: MockSpaceNewsService(articles: [])
        )

        await viewModel.fetchAPOD()

        #expect(viewModel.apodData == nil)
        #expect(viewModel.apodError is APIError)
    }

    @Test func changeNewsTypeTogglesBackToAllWhenTappedTwice() {
        let viewModel = NewsViewModel(
            nasaService: MockAPODService(result: .failure(.missingAPIKey)),
            spaceNewsService: MockSpaceNewsService(articles: [])
        )

        viewModel.changeNewsType(.blogs)
        #expect(viewModel.selectedNewsType == .blogs)

        viewModel.changeNewsType(.blogs)
        #expect(viewModel.selectedNewsType == .all)
    }
}
