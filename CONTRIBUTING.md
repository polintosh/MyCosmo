# Contributing to MyCosmo

Thank you for your interest in contributing to MyCosmo! 🚀✨

This document provides guidelines for contributing to the project. By participating, you agree to follow these guidelines and our code of conduct.

## 🌟 How to Contribute

There are many ways to contribute to MyCosmo:

- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🎨 Enhance UI/UX
- 🔧 Fix issues
- ✅ Write tests
- 🌍 Add translations (future)

## 🚀 Getting Started

### Prerequisites

- macOS 15+
- Xcode 18+
- Swift 6+
- iOS 18+ (for deployment)
- Git

### Setting Up the Development Environment

#### Step 1: Fork and Clone

1. **Fork the repository** on GitHub

2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/MyCosmo.git
   cd MyCosmo
   ```

3. **Add upstream remote:**
   ```bash
   git remote add upstream https://github.com/polintosh/MyCosmo.git
   ```

#### Step 2: Open the Project

1. **Open Xcode 18:**
   ```bash
   open MyCosmo.xcodeproj
   ```

2. **Configure project settings:**
   - Verify **General** tab:
     - **Minimum Deployments** should be **iOS 18.0**
   - Verify **Build Settings** tab:
     - Swift Language Version should be **Swift 6**

#### Step 3: Configure Signing

1. **Open Signing & Capabilities** tab
2. **Select your Apple Developer Team**
3. Xcode will automatically manage signing

#### Step 4: API Keys (Optional)

Most features work without configuration, but for best experience:
- **NASA API**: Get a free key at https://api.nasa.gov
- Configure in the app's Settings or directly in `Services/APODService.swift`

#### Step 5: Build and Run

1. Select a simulator (e.g., iPhone 15 Pro)
2. Press **⌘R** to build and run
3. The app should launch with the onboarding screen

#### Troubleshooting

**Build errors?**
- Clean build folder: **Product > Clean Build Folder** (⌘⇧K)
- Ensure Xcode 18+ is installed
- Verify Swift 6 language mode is enabled

**Still having issues?**
- Open an issue on GitHub with:
  - Xcode version
  - macOS version
  - Error messages
  - Steps you followed

## 🔄 Workflow

### Creating a Branch

Always create a new branch for your work:

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation only
- `refactor/` - Code refactoring
- `test/` - Adding tests
- `chore/` - Maintenance tasks

### Making Changes

1. **Write clean, readable code**
   - Follow Swift conventions
   - Use meaningful variable names
   - Add comments for complex logic
   - Keep functions focused and small

2. **Follow the project architecture:**
   - MVVM pattern
   - Services for API calls
   - Models for data structures
   - Views for UI only
   - ViewModels for business logic

3. **Test your changes:**
   - Run on multiple simulators
   - Test on different iOS versions
   - Check dark mode compatibility
   - Verify accessibility features

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add constellation search feature"
   ```

### Commit Message Guidelines

Use conventional commits format:

```
type(scope): brief description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, no code change
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
```
feat(observations): add photo gallery support
fix(news): resolve article loading crash
docs(readme): update installation instructions
refactor(services): simplify API error handling
```

### Submitting a Pull Request

1. **Update your branch:**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request:**
   - Go to GitHub and click "New Pull Request"
   - Select your fork and branch
   - Fill out the PR template
   - Link related issues

4. **PR Requirements:**
   - [ ] Code builds without errors
   - [ ] Code follows project style
   - [ ] No sensitive data included
   - [ ] Documentation updated (if needed)
   - [ ] Screenshots for UI changes
   - [ ] Tested on simulator/device

## 📋 Pull Request Template

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Related Issues
Fixes #123

## Screenshots (if applicable)
[Add screenshots here]

## Testing
- [ ] Tested on iPhone simulator
- [ ] Tested on iPad simulator
- [ ] Tested on physical device
- [ ] Tested in dark mode
- [ ] Tested with different iOS versions

## Checklist
- [ ] Code follows project conventions
- [ ] Self-reviewed the code
- [ ] Commented complex code sections
- [ ] Updated documentation
- [ ] No warnings in Xcode
- [ ] No sensitive data included
```

## 🎨 Code Style Guidelines

### Swift Style

Follow Apple's [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/):

```swift
// ✅ Good
func fetchPlanetData(for planetID: String) async throws -> PlanetData {
    // Implementation
}

// ❌ Avoid
func get_planet(id: String) -> PlanetData? {
    // Implementation
}
```

### SwiftUI Views

```swift
// ✅ Good - Clean, organized
struct PlanetDetailView: View {
    let planet: PlanetData
    @StateObject private var viewModel: PlanetViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerView
                detailsView
                statsView
            }
        }
        .navigationTitle(planet.name)
    }
    
    private var headerView: some View {
        // Header implementation
    }
}

// ❌ Avoid - Too much in body
struct PlanetDetailView: View {
    var body: some View {
        // 200 lines of code here
    }
}
```

### Naming Conventions

- **Types**: `PascalCase` (e.g., `PlanetData`, `NewsViewModel`)
- **Functions/Variables**: `camelCase` (e.g., `fetchAPOD`, `isLoading`)
- **Constants**: `camelCase` (e.g., `maxPhotoCount`, `defaultTimeout`)
- **Enums**: `PascalCase` with `camelCase` cases

### Organization

Group code logically:
```swift
// MARK: - Properties
// MARK: - Initialization
// MARK: - Lifecycle
// MARK: - Public Methods
// MARK: - Private Methods
// MARK: - API Calls
// MARK: - UI Components
```

## 🔒 Security Guidelines

**NEVER commit:**
- API keys or tokens
- Passwords or credentials
- Personal Apple Developer Team IDs
- Signing certificates or provisioning profiles
- Private keys
- Personal information

**Before committing, check:**
```bash
git diff --staged
```

Look for:
- Hardcoded keys: `"sk_live_"`, `"api_key"`
- Team IDs: `DEVELOPMENT_TEAM =`
- Secrets in strings

## 🐛 Reporting Bugs

When reporting bugs, include:

1. **Description**: Clear description of the issue
2. **Steps to Reproduce**:
   - Step 1
   - Step 2
   - Step 3
3. **Expected Behavior**: What should happen
4. **Actual Behavior**: What actually happens
5. **Environment**:
   - iOS version
   - Device/Simulator
   - Xcode version
   - App version
6. **Screenshots/Videos**: If applicable
7. **Console Logs**: Error messages

Use the bug report template when creating an issue.

## 💡 Feature Requests

When suggesting features:

1. **Use Case**: Why is this needed?
2. **Description**: What should it do?
3. **Mockups**: UI concepts (if applicable)
4. **Alternatives**: Other solutions considered
5. **Impact**: Who benefits from this?

## 🧪 Testing

Currently, MyCosmo doesn't have automated tests, but manual testing is crucial:

### Testing Checklist
- [ ] Test on iPhone SE (small screen)
- [ ] Test on iPhone 15 Pro Max (large screen)
- [ ] Test on iPad
- [ ] Test in Light Mode
- [ ] Test in Dark Mode
- [ ] Test with no network connection
- [ ] Test with slow network
- [ ] Test edge cases (empty states, errors)
- [ ] Test accessibility (VoiceOver)

### Future: Unit Tests
We welcome contributions that add:
- ViewModel tests
- Service layer tests
- Model validation tests

## 📚 Documentation

Good documentation is as important as good code:

- Update README.md for new features
- Add inline comments for complex logic
- Update SECURITY.md for security changes
- Keep architecture diagrams current

### Code Comments

```swift
// ✅ Good - Explains WHY
// Using actor to prevent race conditions with concurrent API calls
actor APODService {
    // ...
}

// ❌ Unnecessary - States the obvious
// This is a function
func fetchData() {
    // ...
}
```

## 🤝 Code Review Process

All contributions go through code review:

1. **Automated checks** (if available)
2. **Maintainer review**
3. **Feedback and discussion**
4. **Revisions if needed**
5. **Approval and merge**

### What Reviewers Look For

- Code quality and style
- Architectural consistency
- Performance implications
- Security concerns
- User experience
- Maintainability

### Responding to Feedback

- Be open to suggestions
- Ask questions if unclear
- Make requested changes
- Re-request review after updates
- Be patient and respectful

## 🌈 Community Guidelines

- Be respectful and inclusive
- Welcome newcomers
- Provide constructive feedback
- Help others learn
- Celebrate contributions

## 📜 License

By contributing, you agree that your contributions will be licensed under the same license as the project: **CC BY-NC-SA 4.0**.

This means:
- ✅ Your work can be shared and adapted
- ✅ You must be credited
- ❌ No commercial use without permission
- ✅ Derivatives must use the same license

## ❓ Questions?

- Open a [Discussion](https://github.com/polintosh/MyCosmo/discussions) on GitHub
- Check existing issues and PRs
- Review the README and documentation

## 🎉 Recognition

Contributors will be:
- Listed in the GitHub contributors page
- Mentioned in release notes (for significant contributions)
- Forever appreciated by the community! 🙏

---

**Thank you for contributing to MyCosmo!** Your efforts help make space exploration accessible to everyone. 🚀✨