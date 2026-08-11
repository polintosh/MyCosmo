//
//  SpaceNewsResponseTests.swift
//  MyCosmoTests
//
//  Decode tests for SpaceNewsArticle/SpaceNewsResponse plus a gotcha test
//  for NewsType.all, which maps to the "articles" endpoint - there is no
//  literal "all" endpoint on the real API.
//

import Foundation
import Testing

@testable import MyCosmo

struct SpaceNewsResponseTests {

    @Test func decodesArticleSnakeCaseKeys() throws {
        let json = """
            {
                "id": 42,
                "title": "New Rocket Test",
                "url": "https://example.com/article",
                "image_url": "https://example.com/image.jpg",
                "news_site": "Space Daily",
                "summary": "A brief summary.",
                "published_at": "2024-01-15T10:00:00.000Z",
                "updated_at": "2024-01-15T12:00:00.000Z"
            }
            """.data(using: .utf8)!

        let article = try JSONDecoder().decode(SpaceNewsArticle.self, from: json)

        #expect(article.imageUrl == "https://example.com/image.jpg")
        #expect(article.newsSite == "Space Daily")
        #expect(article.publishedAt == "2024-01-15T10:00:00.000Z")
    }

    @Test func decodesPaginatedResponse() throws {
        let json = """
            {
                "count": 100,
                "next": "https://api.example.com/page2",
                "previous": null,
                "results": []
            }
            """.data(using: .utf8)!

        let response = try JSONDecoder().decode(SpaceNewsResponse.self, from: json)

        #expect(response.count == 100)
        #expect(response.previous == nil)
    }

    @Test func allNewsTypeMapsToArticlesEndpointNotAll() {
        #expect(NewsType.all.endpoint == "articles")
    }
}
