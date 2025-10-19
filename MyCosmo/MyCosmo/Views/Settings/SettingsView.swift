//
//  SettingsView.swift
//  MyCosmo
//
//  Main settings view for app configuration and preferences.
//  Demonstrates @AppStorage for persistent user preferences, Form/List layouts,
//  and navigation to detail settings screens. Integrates with NASA API for key management.
//
//  Key Features:
//  - @AppStorage for persistent user settings
//  - Theme/appearance mode selection
//  - NASA API key management with rate limit checking
//  - Navigation to About and Acknowledgments screens
//
//  Architecture: Settings view in main tab navigation.
//

import SwiftUI

// MARK: - SettingsView

/// Main settings view for app configuration and user preferences.
/// Uses @AppStorage for automatic persistence of user preferences.
struct SettingsView: View {
    @AppStorage("appearanceMode") private var appearanceMode = 0
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    @AppStorage("nasaApiKey") private var nasaApiKey = ""

    @State private var remainingRequests: Int?
    @State private var showingNASASettings = false
    @State private var isEditingAPIKey = false

    private let appearanceModes = ["System", "Light", "Dark"]
    private let languages = ["English", "Español", "Català"]

    /// Returns the color scheme based on selected appearance mode
    private var colorScheme: ColorScheme? {
        switch appearanceMode {
        case 1: return .light
        case 2: return .dark
        default: return nil
        }
    }

    /// Checks remaining API requests for NASA APOD API
    private func checkRemainingRequests() async {
        let service = APODService()
        remainingRequests = await service.getRemainingAPIRequests()
    }

    var body: some View {
        NavigationStack {
            List {
                // Appearance Section
                Section {
                    HStack {
                        Label {
                            Text("Theme")
                        } icon: {
                            Image(
                                systemName: appearanceMode == 0
                                    ? "circle.lefthalf.filled"
                                    : appearanceMode == 1 ? "sun.max.fill" : "moon.stars.fill"
                            )
                            .foregroundStyle(Color.accentColor)
                            .frame(width: 26)
                        }

                        Spacer()

                        Picker("", selection: $appearanceMode) {
                            ForEach(0..<appearanceModes.count, id: \.self) { index in
                                Text(appearanceModes[index])
                            }
                        }
                        .labelsHidden()
                    }
                } header: {
                    Text("Appearance")
                }

                // NASA API Section
                Section {
                    if nasaApiKey.isEmpty {
                        Button {
                            showingNASASettings = true
                        } label: {
                            HStack {
                                Label {
                                    Text("Add NASA API Key")
                                } icon: {
                                    Image(systemName: "key.fill")
                                        .foregroundStyle(Color.orange)
                                        .frame(width: 26)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    } else {
                        HStack {
                            Label {
                                Text("API Key")
                            } icon: {
                                Image(systemName: "key.fill")
                                    .foregroundStyle(Color.green)
                                    .frame(width: 26)
                            }

                            Spacer()

                            Text("Configured")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)

                            Button {
                                showingNASASettings = true
                            } label: {
                                Image(systemName: "pencil")
                            }
                            .buttonStyle(.plain)
                        }

                        if let remaining = remainingRequests {
                            HStack {
                                Label {
                                    Text("Remaining Requests")
                                } icon: {
                                    Image(systemName: "chart.bar.fill")
                                        .foregroundStyle(Color.blue)
                                        .frame(width: 26)
                                }

                                Spacer()

                                Text("\(remaining)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                } header: {
                    Text("NASA API")
                } footer: {
                    Text(
                        "A free NASA API key is required to access the Astronomy Picture of the Day feature. Get your key at api.nasa.gov"
                    )
                }

                // About Section
                Section {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label {
                            Text("About")
                        } icon: {
                            Image(systemName: "info.circle.fill")
                                .foregroundStyle(Color.blue)
                                .frame(width: 26)
                        }
                    }

                    NavigationLink {
                        AcknowledgmentsView()
                    } label: {
                        Label {
                            Text("Acknowledgments")
                        } icon: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(Color.pink)
                                .frame(width: 26)
                        }
                    }
                } header: {
                    Text("Information")
                }
            }
            .navigationTitle("Settings")
            .preferredColorScheme(colorScheme)
            .sheet(isPresented: $showingNASASettings) {
                NavigationStack {
                    List {
                        Section {
                            TextField("NASA API Key", text: $nasaApiKey)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        } header: {
                            Text("API Key")
                        } footer: {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(
                                    "Enter your NASA API key to access the Astronomy Picture of the Day feature."
                                )

                                Link(
                                    "Get a free API key at api.nasa.gov",
                                    destination: URL(string: "https://api.nasa.gov")!
                                )
                            }
                        }
                    }
                    .navigationTitle("NASA API")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showingNASASettings = false
                            }
                        }
                    }
                }
            }
            .task {
                if !nasaApiKey.isEmpty {
                    await checkRemainingRequests()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
