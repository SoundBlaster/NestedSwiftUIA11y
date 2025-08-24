# NestedA11yIDs

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platforms-iOS%2015.0%20%7C%20macOS%2012.0%20%7C%20tvOS%2015.0%20%7C%20watchOS%208.0-blue.svg)](https://apple.com)

A Swift Package that provides hierarchical (nested) accessibility identifiers for SwiftUI.

## Overview

NestedA11yIDs makes it easy to implement consistent, maintainable accessibility identifiers in SwiftUI applications by providing a hierarchical approach to identifier composition.

Instead of managing lengthy, error-prone string literals throughout your codebase, NestedA11yIDs allows you to:

- Define a root identifier for each major component
- Add component-specific identifiers to child views
- Automatically compose dot-separated identifiers that reflect the view hierarchy

### Before

```swift
VStack {
    Text("Welcome")
        .accessibilityIdentifier("login_welcome_title")
        
    TextField("Email", text: $email)
        .accessibilityIdentifier("login_email_field")
        
    SecureField("Password", text: $password)
        .accessibilityIdentifier("login_password_field")
        
    Button("Sign In") {
        // Action
    }
    .accessibilityIdentifier("login_signin_button")
}
```

### After

```swift
VStack {
    Text("Welcome")
        .nestedAccessibilityIdentifier("title")
        
    TextField("Email", text: $email)
        .nestedAccessibilityIdentifier("email")
        
    SecureField("Password", text: $password)
        .nestedAccessibilityIdentifier("password")
        
    Button("Sign In") {
        // Action
    }
    .nestedAccessibilityIdentifier("button")
}
.a11yRoot("login")
```

Both approaches will make the elements accessible in UI tests with identifiers like `login.title`, `login.email`, etc. However, the nested approach:

- Eliminates duplication and prefix repetition
- Makes refactoring easier (change the root identifier in one place)
- Keeps identifier logic closer to the view hierarchy
- Automatically marks containers with `.accessibilityElement(children: .contain)`

## Installation

### Swift Package Manager

Add NestedA11yIDs to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/NestedA11yIDs.git", from: "1.0.0")
]
```

Or add it directly in Xcode using File → Add Packages.

## Usage

### Basic Example

```swift
import SwiftUI
import NestedA11yIDs

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Text("Welcome Back")
                .nestedAccessibilityIdentifier("title")
                
            TextField("Email", text: $email)
                .nestedAccessibilityIdentifier("email")
                
            SecureField("Password", text: $password)
                .nestedAccessibilityIdentifier("password")
                
            Button("Sign In") {
                // Action
            }
            .nestedAccessibilityIdentifier("button")
        }
        .a11yRoot("login")
    }
}
```

### Nested Containers

```swift
VStack {
    // Header section
    VStack {
        Text("Create Account")
            .nestedAccessibilityIdentifier("title")
    }
    .nestedAccessibilityIdentifier("header")
    
    // Form section
    VStack {
        TextField("Email", text: $email)
            .nestedAccessibilityIdentifier("email")
            
        SecureField("Password", text: $password)
            .nestedAccessibilityIdentifier("password")
        
        Button("Register") {
            // Action
        }
        .nestedAccessibilityIdentifier("button")
    }
    .nestedAccessibilityIdentifier("form")
}
.a11yRoot("registration")
```

This will generate identifiers like:
- `registration.header.title`
- `registration.form.email`
- `registration.form.password`
- `registration.form.button`

### UI Testing

Once you've implemented nested accessibility identifiers, you can easily target elements in UI tests:

```swift
let app = XCUIApplication()
app.launch()

// Find and tap the login button
app.buttons["login.button"].tap()

// Type in the registration email field
app.textFields["registration.form.email"].typeText("user@example.com")
```

## Special Cases and Caveats

### SwiftUI Button Behavior

SwiftUI `Button` views handle accessibility identifiers in a special way. The button's label (not the button itself) receives the identifier for VoiceOver purposes. However, UI tests can still locate the button using the composed identifier.

This means:
- VoiceOver will read the button's label text
- UI tests can find the button using the full hierarchical path

## Documentation

For more detailed documentation, build the DocC documentation included with the package or visit the [Documentation Website](https://yourusername.github.io/NestedA11yIDs/documentation/nesteda11yids).

## License

NestedA11yIDs is available under the MIT license. See the LICENSE file for more info.