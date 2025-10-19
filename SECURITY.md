# Security Policy

## 🔒 Security Best Practices

MyCosmo is designed with security in mind. This document outlines security considerations for developers and users.

## API Keys and Sensitive Data

### ⚠️ IMPORTANT: Never Commit API Keys

This project uses external APIs that may require API keys:

- **NASA API**: Required for Astronomy Picture of the Day (APOD)
- **Spaceflight News API**: Public API (no key required)

### How API Keys Are Managed

API keys in MyCosmo are stored in `UserDefaults` and are **NOT** included in the repository. This is intentional for security.

#### For Developers:

1. **Obtain your own API keys:**
   - NASA API: https://api.nasa.gov
   - Register for a free API key (takes seconds)

2. **Configure keys in the app:**
   - Keys are stored locally in UserDefaults
   - Set via the app's settings interface
   - Keys are device-specific and never synced

3. **Never hardcode API keys:**
   ```swift
   // ❌ BAD - Don't do this
   let apiKey = "your_api_key_here"
   
   // ✅ GOOD - Use UserDefaults or secure storage
   let apiKey = UserDefaults.standard.string(forKey: "nasaApiKey") ?? ""
   ```

### What's Excluded from Version Control

The following sensitive items are excluded via `.gitignore`:

- ✅ Signing certificates (`.p12`, `.cer`)
- ✅ Provisioning profiles (`.mobileprovision`, `.provisionprofile`)
- ✅ Certificate signing requests (`.certSigningRequest`)
- ✅ Private keys (`.pem`)
- ✅ Environment files (`.env`, `.env.local`)
- ✅ Configuration files with secrets (`secrets.xcconfig`, `APIKeys.plist`)
- ✅ User-specific Xcode data (`xcuserdata/`)
- ✅ Build artifacts and derived data

## Code Signing and Distribution

### For Open Source Contributors

The project is configured with **Manual Code Signing** and intentionally leaves the following blank:

- `DEVELOPMENT_TEAM`: Empty (removed from project file)
- `PROVISIONING_PROFILE_SPECIFIER`: Empty
- `CODE_SIGN_IDENTITY`: Set to "Apple Development" (generic)

**This is correct and intentional.** Each developer should:

1. Open the project in Xcode
2. Select the target → Signing & Capabilities
3. Choose your own development team
4. Xcode will automatically configure signing for your account
5. These changes are stored in `xcuserdata/` which is gitignored

### Building the App

To build MyCosmo:

1. Clone the repository
2. Open `MyCosmo.xcodeproj` in Xcode 18+
3. Ensure Swift 6 language mode is enabled
4. Select your development team in Signing & Capabilities
5. Build and run

**Requirements:**
- Xcode 18+
- Swift 6+
- iOS 18+ deployment target
- macOS 15+ for development

No additional certificates or profiles are needed for simulator builds. For device testing, use your own Apple Developer account.
</text>

<old_text line=189>
## Updates and Maintenance

This security policy is reviewed and updated regularly. Last update: January 2025

## Reporting Security Vulnerabilities

If you discover a security vulnerability, please report it responsibly:

### DO NOT:
- ❌ Open a public GitHub issue
- ❌ Disclose the vulnerability publicly before it's fixed

### DO:
- ✅ Email the maintainer directly (check README for contact)
- ✅ Provide detailed information about the vulnerability
- ✅ Allow reasonable time for a fix before public disclosure

### What to Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if you have one)

## Security Checklist for Contributors

Before submitting a PR, ensure:

- [ ] No API keys or secrets in code
- [ ] No hardcoded credentials
- [ ] No personal team IDs or signing identities
- [ ] Sensitive data uses secure storage (Keychain, not UserDefaults for production)
- [ ] No personal information in commit messages
- [ ] `.gitignore` is respected

## Data Privacy

MyCosmo respects user privacy:

- **No Analytics**: No tracking or analytics SDKs
- **No Ads**: No advertising frameworks
- **Local Storage**: User observations are stored locally using SwiftData
- **No Cloud Sync**: Currently no iCloud or remote storage (future feature)
- **Minimal Permissions**: Only requests necessary permissions
- **Public APIs**: Uses public space and astronomy APIs

## Secure Coding Practices

### Input Validation
All user inputs are validated and sanitized before processing.

### Network Security
- Uses HTTPS for all API communications
- URL validation before network requests
- Error handling for failed requests

### Data Persistence
- SwiftData for local observations
- UserDefaults for non-sensitive preferences
- Future: Consider Keychain for sensitive data

## License Compliance

MyCosmo is licensed under CC BY-NC-SA 4.0:
- ✅ Free for personal and educational use
- ❌ Commercial use requires permission
- ✅ Modifications must use the same license
- ✅ Attribution required

## Updates and Maintenance

This security policy is reviewed and updated regularly. Last update: January 2025

**Current Requirements:**
- Xcode 18+
- Swift 6+
- iOS 18+
- macOS 15+ for development

---

**Remember**: Security is everyone's responsibility. When in doubt, ask before committing!