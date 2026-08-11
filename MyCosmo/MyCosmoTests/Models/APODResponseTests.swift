//
//  APODResponseTests.swift
//  MyCosmoTests
//
//  Decode tests for APODResponse - verifies the snake_case-to-camelCase
//  CodingKeys mapping against real API shapes, no network required.
//

import Foundation
import Testing

@testable import MyCosmo

struct APODResponseTests {

    @Test func decodesSnakeCaseMediaTypeKey() throws {
        let json = """
            {
                "date": "2024-01-15",
                "explanation": "A stunning nebula.",
                "hdurl": "https://example.com/hd.jpg",
                "media_type": "image",
                "title": "Nebula of the Day",
                "url": "https://example.com/sd.jpg"
            }
            """.data(using: .utf8)!

        let response = try JSONDecoder().decode(APODResponse.self, from: json)

        #expect(response.mediaType == "image")
        #expect(response.title == "Nebula of the Day")
        #expect(response.hdurl == "https://example.com/hd.jpg")
    }

    @Test func decodesWithoutOptionalHdurl() throws {
        let json = """
            {
                "date": "2024-01-15",
                "explanation": "A video today.",
                "media_type": "video",
                "title": "Rocket Launch",
                "url": "https://example.com/video"
            }
            """.data(using: .utf8)!

        let response = try JSONDecoder().decode(APODResponse.self, from: json)

        #expect(response.hdurl == nil)
        #expect(response.mediaType == "video")
    }
}
