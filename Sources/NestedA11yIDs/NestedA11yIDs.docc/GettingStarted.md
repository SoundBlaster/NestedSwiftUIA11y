# Getting Started with NestedA11yIDs

Create hierarchical accessibility identifiers for your SwiftUI views.

## Overview

NestedA11yIDs simplifies the management of accessibility identifiers in SwiftUI applications by providing a hierarchical approach that follows your view structure. This guide will help you quickly integrate nested accessibility identifiers into your SwiftUI project.

## Basic Usage

### Setting a Root Identifier

Start by setting a root identifier at the top level of your component or screen:

```swift
VStack {
    // Child views
}
.a11yRoot("login")
```

### Adding Identifiers to Child Views

Add identifiers to child views that will automatically be prefixed with the parent's identifier:

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

This will generate the following accessibility identifiers:
- `login.title`
- `login.email`
- `login.password`
- `login.button`

### Nested Containers

You can nest containers to create deeper hierarchies:

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

## UI Testing

Once you've implemented nested accessibility identifiers, you can easily target elements in UI tests:

```swift
let app = XCUIApplication()
app.launch()

// Find and tap the login button
app.buttons["login.button"].tap()

// Type in the registration email field
app.textFields["registration.form.email"].typeText("user@example.com")
```

## Next Steps

Explore the <doc:HowItWorks> guide to learn more about how NestedA11yIDs works behind the scenes.