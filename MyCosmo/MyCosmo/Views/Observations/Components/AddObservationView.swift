//
//  AddObservationView.swift
//  MyCosmo
//
//  View for creating new astronomical observations with images and metadata.
//  Demonstrates SwiftUI Form layouts, PhotosUI integration for image selection,
//  and SwiftData insertion. Uses comprehensive validation and data handling.
//
//  Key Features:
//  - PhotosPicker for multi-image selection
//  - Toggle between custom images and default planet images
//  - Form validation before saving
//  - Image compression for efficient storage
//  - SwiftData integration for persistence
//
//  Architecture: Form view in Observations feature, presented as a sheet.
//

import PhotosUI
import SwiftData
import SwiftUI

// MARK: - AddObservationView

/// Form view for creating and saving new astronomical observations.
/// Uses PhotosUI for image selection and SwiftData for persistence.
struct AddObservationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var title = ""
    @State private var description = ""
    @State private var selectedPlanet: Planet = .earth
    @State private var customPlanet = ""
    @State private var category = ObservationCategory.other
    @State private var importance = ImportanceLevel.medium
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var useCustomImages = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            Form {
                // Image Selection Section
                Section("Images") {
                    Toggle("Use Custom Images", isOn: $useCustomImages)

                    if useCustomImages {
                        PhotosPicker(
                            selection: $selectedItems,
                            maxSelectionCount: 10,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Label("Select Images", systemImage: "photo.stack")
                        }

                        if !selectedImages.isEmpty {
                            // Image carousel preview
                            TabView {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 200)
                                }
                            }
                            .frame(height: 200)
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .always))

                            // Thumbnail grid with delete buttons
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(selectedImages.indices, id: \.self) { index in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: selectedImages[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))

                                        Button {
                                            selectedImages.remove(at: index)
                                            selectedItems.remove(at: index)
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundStyle(.white, Color(.systemGray3))
                                                .background(
                                                    Circle().fill(Color.black.opacity(0.5)))
                                        }
                                        .offset(x: 6, y: -6)
                                    }
                                }
                            }
                            .padding(.top, 8)
                        } else {
                            ContentUnavailableView(
                                "No Images Selected",
                                systemImage: "photo.stack",
                                description: Text("Select up to 10 images")
                            )
                            .frame(height: 200)
                        }
                    } else {
                        selectedPlanet.defaultImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 3)
                            .padding(.horizontal)
                    }
                }

                // Basic Information Section
                Section("Basic Information") {
                    TextField("Title", text: $title)

                    Picker("Planet", selection: $selectedPlanet) {
                        ForEach(Planet.allCases, id: \.self) { planet in
                            Text(planet.rawValue).tag(planet)
                        }
                    }

                    if selectedPlanet == .other {
                        TextField("Custom planet name", text: $customPlanet)
                    }
                }

                // Description Section
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                        .overlay(alignment: .topLeading) {
                            if description.isEmpty {
                                Text("Describe your observation...")
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                            }
                        }
                }

                // Classification Section
                Section("Classification") {
                    Picker("Category", selection: $category) {
                        ForEach(ObservationCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }

                    Picker("Importance", selection: $importance) {
                        ForEach(ImportanceLevel.allCases, id: \.self) { level in
                            Text(level.rawValue).tag(level)
                        }
                    }
                }
            }
            .navigationTitle("New Observation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveObservation()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .onChange(of: selectedItems) { oldValue, newValue in
            Task {
                selectedImages.removeAll()

                for item in newValue {
                    if let data = try? await item.loadTransferable(type: Data.self),
                        let image = UIImage(data: data)
                    {
                        selectedImages.append(image)
                    }
                }
            }
        }
    }

    /// Validates if the form has required fields filled
    private var isFormValid: Bool {
        !title.isEmpty
            && !description.isEmpty
            && (selectedPlanet != .other || !customPlanet.isEmpty)
    }

    /// Creates and saves observation to SwiftData
    private func saveObservation() {
        var mainImageData: Data? = nil
        var additionalImagesData: [Data] = []

        if useCustomImages && !selectedImages.isEmpty {
            mainImageData = selectedImages[0].jpegData(compressionQuality: 0.8)

            if selectedImages.count > 1 {
                additionalImagesData = selectedImages[1...].compactMap {
                    $0.jpegData(compressionQuality: 0.8)
                }
            }
        }

        let observation = UserObservation(
            title: title,
            description: description,
            selectedPlanet: selectedPlanet,
            customPlanet: selectedPlanet == .other ? customPlanet : nil,
            category: category,
            importance: importance,
            customImage: mainImageData,
            additionalImages: additionalImagesData.isEmpty ? nil : additionalImagesData
        )
        modelContext.insert(observation)
        dismiss()
    }
}
