<img width="1920" height="1080" alt="Cover" src="https://github.com/user-attachments/assets/e06a826a-ac1c-47f5-a679-f7ac768267c8" />

---

> Be your universe.

MyCosmo is a comprehensive iOS application that brings the wonders of space exploration and astronomy right to your fingertips. Built with modern Swift technologies, it offers an immersive experience for space enthusiasts to explore, learn, and document their astronomical journey.

## ✨ Features

### 🌌 Space News Feed
- Real-time space news and discoveries powered by Spaceflight News API
- Filter news by type: Articles, Blogs, and Reports
- Beautiful card-based layout with article images
- Direct links to full articles
- Pull-to-refresh functionality

### 🌠 NASA's Astronomy Picture of the Day (APOD)
- Daily stunning space imagery with detailed explanations
- High-resolution images with smooth loading states
- Detailed view with title, date, and comprehensive descriptions
- Direct integration with NASA's APOD API

### 🪐 Solar System Explorer
- Interactive grid view of all planets in our solar system
- Detailed planet information including:
  - Physical characteristics (radius, mass, gravity)
  - Orbital properties (distance from sun, orbital period)
  - Atmospheric composition
  - Number of moons
  - Surface temperature
- Visual planet representations with custom colors
- Search and filter capabilities

### 📝 Personal Observations Tracker
- Create and manage your own astronomical observations
- Rich observation entries with:
  - Title and detailed descriptions
  - Planet/celestial body association
  - Category classification (Constellation, Planet, Star, Meteor, Other)
  - Importance levels (Low, Medium, High, Critical)
  - Photo attachments (up to 3 images)
  - Automatic timestamps
- Advanced filtering by category, importance, and planet
- SwiftData persistence for offline access
- Detailed observation view with image galleries

### ⚙️ Settings & Customization
- Appearance mode control (System, Light, Dark)
- App version and build information
- About section with:
  - Developer information
  - GitHub repository link
  - License information (CC BY-NC-SA 4.0)
  - Contact options

### 🎯 Onboarding Experience
- Beautiful multi-page onboarding flow
- Welcome screen with app introduction
- Feature showcase with expandable descriptions
- Getting started guide
- First-launch experience

## 🛠 Technologies

### Core Technologies
- **Swift 6+**: Modern Swift programming with the latest language features and strict concurrency
- **SwiftUI**: Declarative UI framework for native iOS development
- **iOS 18+**: Leveraging the latest iOS capabilities
- **Async/Await**: Modern concurrency for efficient asynchronous operations
- **SwiftData**: Apple's latest data persistence framework for local storage

### APIs & Services
- **Spaceflight News API**: Real-time space news aggregation
- **NASA APOD API**: Access to NASA's Astronomy Picture of the Day
- **Custom Solar System Data**: Comprehensive planetary information

### Design Patterns
- **MVVM Architecture**: Clean separation between UI and business logic
- **Service Layer Pattern**: Dedicated services for API communication
- **Repository Pattern**: Abstracted data access layer
- **Dependency Injection**: Loosely coupled, testable components

## 🏗 Architecture

### Project Structure

```
MyCosmo/
├── Models/
│   ├── APODResponse.swift          # NASA APOD data model
│   ├── SpaceNewsResponse.swift     # Space news articles model
│   ├── PlanetData.swift            # Solar system planet model
│   ├── UserObservation.swift       # User observation model (SwiftData)
│   └── OnboardingItem.swift        # Onboarding content model
│
├── Views/
│   ├── MainTabView.swift           # Main tab navigation
│   │
│   ├── News/
│   │   ├── NewsView.swift          # Main news feed
│   │   └── Components/
│   │       └── APODDetailView.swift
│   │
│   ├── SolarSystem/
│   │   ├── SolarSystemView.swift   # Planet grid view
│   │   └── PlanetDetailView.swift  # Individual planet details
│   │
│   ├── Observations/
│   │   ├── ObservationsView.swift  # Observations list
│   │   ├── ObservationDetailView.swift
│   │   └── Components/
│   │       └── AddObservationView.swift
│   │
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   └── AboutView.swift
│   │
│   ├── Onboarding/
│   │   ├── OnboardingView.swift
│   │   ├── WelcomeView.swift
│   │   ├── FeaturesView.swift
│   │   └── GetStartedView.swift
│   │
│   └── Components/
│       ├── InfoSheet.swift         # Reusable info sheet
│       └── InfoSheetRow.swift
│
├── ViewModels/
│   ├── News/
│   │   └── NewsViewModel.swift
│   ├── SolarSystem/
│   │   └── SolarSystemViewModel.swift
│   └── Observations/
│       ├── ObservationsViewModel.swift
│       └── ObservationDetailViewModel.swift
│
├── Services/
│   ├── SpaceNewsService.swift      # Space news API client
│   ├── APODService.swift           # NASA APOD API client
│   └── SolarSystemService.swift    # Solar system data provider
│
├── Resources/
│   └── Preview Content/
│
└── MyCosmoApp.swift               # App entry point
```

### Key Architectural Patterns

#### MVVM (Model-View-ViewModel)
- **Models**: Pure data structures representing app entities
- **Views**: SwiftUI views focusing purely on UI presentation
- **ViewModels**: `@MainActor` classes handling business logic and state management

#### Service Layer
- Dedicated service classes for external API communication
- Centralized error handling and API key management
- Async/await based networking

#### Data Persistence
- **SwiftData**: Native Apple framework for user observations
- **@AppStorage**: Lightweight preference storage (onboarding status, appearance mode)
- **@Query**: Reactive SwiftData queries with automatic UI updates

#### State Management
- `@Published` properties in ViewModels for reactive updates
- `@State` and `@StateObject` in Views for local and observed state
- `@Environment` for system-wide settings (colorScheme, modelContext)

## 📱 Key Features Deep Dive

### News Module
The news feed aggregates space-related articles, blogs, and reports using the Spaceflight News API. Users can filter content by type and each article includes rich imagery and metadata. The APOD feature showcases NASA's daily astronomical photograph with educational descriptions.

### Solar System Explorer
An interactive catalog of our solar system's planets with comprehensive data including physical properties, orbital characteristics, atmospheric composition, and more. Each planet has a dedicated detail view with organized information sections.

### Observations Tracker
A personal journal for astronomical observations. Users can document their stargazing experiences with photos, detailed notes, and categorical organization. The filtering system allows quick access to specific types of observations, importance levels, or celestial bodies.

### Settings & Customization
Full control over the app experience including light/dark mode preferences. The settings also provide transparency about the app with version information, licensing details, and direct access to the developer.

## 🚀 Getting Started

### Requirements
- iOS 18+
- Xcode 18+
- Swift 6+
- macOS 15+ (for development)

### Installation

⚠️ **Important Note for Collaborators**: This repository currently does not include the `.xcodeproj` file because it was previously in the `.gitignore`. You'll need to create the Xcode project manually following these steps:

#### Option 1: Create Xcode Project from Source Files (Recommended)
1. Clone the repository:
   ```bash
   git clone https://github.com/polintosh/MyCosmo.git
   cd MyCosmo
   ```

2. Open Xcode 18 and create a new project:
   - Select **File > New > Project**
   - Choose **iOS > App** template
   - Configure the project:
     - **Product Name**: MyCosmo
     - **Team**: Select your development team
     - **Organization Identifier**: Your identifier (e.g., `com.yourname`)
     - **Interface**: SwiftUI
     - **Language**: Swift
     - **Storage**: SwiftData (important!)
   - Save it in the root of the cloned repository (next to the existing `MyCosmo` folder)

3. Replace the default source files:
   - In Xcode's Project Navigator, delete the default `MyCosmoApp.swift` and `ContentView.swift` files
   - Drag and drop the existing `MyCosmo/MyCosmo` folder from Finder into your Xcode project
   - When prompted, select:
     - ✅ **Copy items if needed** (unchecked, since files are already in place)
     - ✅ **Create groups**
     - ✅ Add to target: MyCosmo

4. Configure the project settings:
   - Select the project in the Project Navigator
   - Under **General** tab:
     - Set **Minimum Deployments** to iOS 18.0
   - Under **Build Settings** tab:
     - Search for "Swift Language Version" and ensure it's set to Swift 6

5. Build and run the project (⌘R)

#### Option 2: Wait for Project File
If you're having trouble with Option 1, the maintainer will soon add the `.xcodeproj` file to the repository. Check back soon or open an issue requesting it.

### Once the .xcodeproj is Available
1. Clone the repository:
   ```bash
   git clone https://github.com/polintosh/MyCosmo.git
   ```
2. Open `MyCosmo.xcodeproj` in Xcode
3. Select your target device or simulator
4. Build and run the project (⌘R)

### API Configuration
The app uses public APIs that may require API keys:
- **NASA API**: Some features work with the demo key, but you can get your own at [api.nasa.gov](https://api.nasa.gov)
- **Spaceflight News API**: No API key required (public API)

To configure API keys, update the respective service files in the `Services/` directory.

## 🎨 Design Philosophy

MyCosmo follows Apple's Human Interface Guidelines with:
- Native SwiftUI components
- Dynamic Type support
- Smooth animations and transitions
- Adaptive layouts for different screen sizes
- Dark mode support
- SF Symbols integration
- Blur effects and modern iOS design patterns

## 🔮 Future Enhancements

- [ ] Real-time ISS tracking
- [ ] Stargazing weather forecast integration
- [ ] Augmented Reality planet viewer
- [ ] Social sharing of observations
- [ ] iCloud sync for observations across devices
- [ ] Widgets for APOD and ISS location
- [ ] Push notifications for space events
- [ ] More celestial bodies (moons, asteroids, comets)

## 📄 License

This project is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License (CC BY-NC-SA 4.0)**.

### You are free to:
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material

### Under the following terms:
- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made
- **NonCommercial** — You may not use the material for commercial purposes
- **ShareAlike** — If you remix, transform, or build upon the material, you must distribute your contributions under the same license

For more information, visit: https://creativecommons.org/licenses/by-nc-sa/4.0/

## 👨‍💻 Developer

**Pol Hernàndez**
- GitHub: [@polintosh](https://github.com/polintosh)
- Project: [MyCosmo Repository](https://github.com/polintosh/MyCosmo)

## 🙏 Acknowledgments

- NASA for providing the APOD API
- The Spaceflight News API team
- Apple for SwiftUI and Swift Data frameworks
- The open-source community

---

<p align="center">
  <img width="1624" height="975" alt="Screenshot 2025-10-19 at 18 04 35" src="https://github.com/user-attachments/assets/92d4ee42-4522-4251-a496-0bd22280f3a9" />
  Made with ❤️ and ☕ for space enthusiasts everywhere
</p>
