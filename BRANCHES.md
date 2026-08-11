# Branches

MyCosmo maintains the same app across three branches, each targeting a different iOS SDK generation. GitHub only shows `main` by default - check out the branch that matches the Xcode/SDK you have installed, or compare branches to see how idiomatic SwiftUI code changed over time.

This file's content is identical on every branch; each branch's `README.md` also has a short "This Branch" section at the top with the same information in context.

| Branch | iOS Deployment Target | Swift | Pattern |
| --- | --- | --- | --- |
| [`ios17-baseline`](https://github.com/polintosh/MyCosmo/tree/ios17-baseline) | 17.0 (SwiftData's minimum supported OS) | Swift 5 language mode | Classic `ObservableObject`/`@Published` view models with explicit `@MainActor` annotations |
| [`ios18`](https://github.com/polintosh/MyCosmo/tree/ios18) | 18.0 | Swift 6 language mode | `@Observable` macro view models |
| [`main`](https://github.com/polintosh/MyCosmo/tree/main) | 26.0 (latest) | Swift 6 language mode | `@Observable` macro view models, adopts newer SwiftUI APIs where they fit |

## Why iOS 17 is the floor

[SwiftData](https://developer.apple.com/documentation/swiftdata) - used for the app's Observations feature - requires iOS 17.0+. Apple never shipped it for iOS 16 or earlier, so `ios17-baseline` is as far back as this app can reasonably go while keeping that feature.

## Switching branches

```bash
git checkout ios17-baseline   # or ios18, or main
```

Each branch's Xcode project has its own `IPHONEOS_DEPLOYMENT_TARGET` and `SWIFT_VERSION` build settings already configured - no manual project changes needed after checkout.
