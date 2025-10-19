//
//  NewsView.swift
//  MyCosmo
//
//  Main view for displaying space news and NASA's APOD content.
//  Demonstrates SwiftUI patterns: ScrollView layouts, async data fetching,
//  filtered content display, and sheet presentations. Uses MVVM with NewsViewModel.
//
//  Key Features:
//  - Horizontal scrolling filter pills for news categories
//  - Lazy grid layout for efficient article rendering
//  - NASA APOD integration via toolbar button
//  - Async/await data fetching with .task modifier
//
//  Architecture: View layer consuming NewsViewModel in MVVM pattern.
//

import SwiftData
import SwiftUI

// MARK: - NewsView

/// Main view for space news and NASA's APOD.
/// Uses ViewModel for state management and service layer communication.
struct NewsView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var showingAPOD = false
    @State private var showingInfo = false
    @Environment(\.colorScheme) private var colorScheme

    /// Content for the information sheet
    private let infoContent = InfoSheetContent(
        icon: "newspaper.fill",
        title: "Space News",
        subtitle:
            "Stay up to date with the latest space news, launches, and discoveries from around the world.",
        features: [
            (
                symbol: "newspaper.fill", title: "Space News",
                description: "Latest articles from SpaceFlightNews API"
            ),
            (
                symbol: "camera.badge.clock", title: "NASA APOD",
                description: "NASA's Astronomy Picture of the Day"
            ),
            (
                symbol: "line.3.horizontal.decrease.circle", title: "News Filters",
                description: "Filter by articles, blogs, or reports"
            ),
        ],
        technologies: [
            (
                symbol: "swift", title: "Swift Features",
                description: "Async/await, SwiftUI, MVVM architecture"
            ),
            (symbol: "network", title: "APIs", description: "SpaceFlightNews API, NASA APOD API"),
        ]
    )

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // News Type Filter Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(NewsType.allCases, id: \.self) { type in
                                FilterPillButton(
                                    type: type,
                                    isSelected: viewModel.selectedNewsType == type,
                                    action: { viewModel.changeNewsType(type) }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)

                    // News Articles Grid
                    let columns = [
                        GridItem(.adaptive(minimum: 300), spacing: 16)
                    ]

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.newsArticles) { article in
                            NewsCard(article: article)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Space News")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.fetchAPOD()
                            showingAPOD = true
                        }
                    } label: {
                        Image(systemName: "camera.badge.clock")
                    }
                }
            }
            .sheet(isPresented: $showingInfo) {
                InfoSheet(content: infoContent)
            }
            .sheet(isPresented: $showingAPOD) {
                APODDetailView(apodData: viewModel.apodData, error: viewModel.apodError)
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .task {
                await viewModel.fetchNews()
            }
        }
    }
}

// MARK: - NewsType Color Extension

/// Extension to provide UI colors for NewsType enum.
/// Kept in View layer to avoid main-actor isolation issues in the model layer.
extension NewsType {
    var color: Color {
        switch self {
        case .all: return .blue
        case .articles: return .green
        case .blogs: return .orange
        case .reports: return .purple
        case .launches: return .red
        }
    }
}

// MARK: - FilterPillButton

/// Button for filtering news by category with capsule shape.
/// Displays icon and text with selection state styling.
struct FilterPillButton: View {
    let type: NewsType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: type.icon)
                Text(type.rawValue)
            }
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(isSelected ? .white : type.color)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? type.color : type.color.opacity(0.15))
            )
        }
    }
}

// MARK: - NewsCard

/// Card view for displaying a space news article.
/// Uses AsyncImage for loading article images and Link for external navigation.
struct NewsCard: View {
    let article: SpaceNewsArticle
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Link(destination: URL(string: article.url)!) {
            VStack(alignment: .leading, spacing: 12) {
                // Article Image
                AsyncImage(url: URL(string: article.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay {
                                ProgressView()
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(16 / 9, contentMode: .fit)
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay {
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            }
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Article Content
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)

                    Text(article.summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)

                    // Article Metadata
                    HStack(alignment: .center, spacing: 8) {
                        Text(article.newsSite)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)

                        Spacer()

                        Text(formatDate(article.publishedAt))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(colorScheme == .dark ? Color(.systemGray6) : .white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
        }
    }

    /// Formats the article's publication date
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = formatter.date(from: dateString) else { return dateString }

        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
