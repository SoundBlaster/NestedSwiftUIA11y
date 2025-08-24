# ``NestedA11yIDs``

A Swift Package that provides hierarchical (nested) accessibility identifiers for SwiftUI.

## Overview

NestedA11yIDs makes it easy to implement consistent, maintainable accessibility identifiers in SwiftUI applications by providing a hierarchical approach to identifier composition.

Instead of managing lengthy, error-prone string literals throughout your codebase, NestedA11yIDs allows you to:

- Define a root identifier for each major component
- Add component-specific identifiers to child views
- Automatically compose dot-separated identifiers that reflect the view hierarchy

## Benefits of Nested Accessibility Identifiers

Hierarchical identifiers offer several advantages over flat identifiers:

- **Improved readability**: Identifiers like `login.registration.button` clearly communicate the view hierarchy
- **Simplified refactoring**: Changing a parent identifier automatically updates all child identifiers
- **Reduced collisions**: Hierarchical namespacing minimizes accidental duplicates
- **Better organization**: Identifiers naturally map to your view structure

## Getting Started

Add the NestedA11yIDs package to your project:

```swift
dependencies: [
    .package(url: "https://github.com/SoundBlaster/NestedA11yIDs.git", from: "1.0.0")
]
```

Then import the package in your SwiftUI files:

```swift
import SwiftUI
import NestedA11yIDs
```

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:HowItWorks>

### View Modifiers

- ``View/a11yRoot(_:)``
- ``View/nestedAccessibilityIdentifier(_:)``

### Environment

- ``EnvironmentValues/accessibilityPrefix``
