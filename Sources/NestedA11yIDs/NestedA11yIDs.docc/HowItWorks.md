# How NestedA11yIDs Works

Learn about the implementation details of hierarchical accessibility identifiers.

## Overview

NestedA11yIDs provides a clean, hierarchical approach to managing accessibility identifiers in SwiftUI by leveraging SwiftUI's Environment system. This guide explains the underlying mechanisms and design decisions.

## Core Components

The package consists of three main components:

1. **Environment Value**: An environment key that propagates the current accessibility prefix down the view hierarchy
2. **Composition Utility**: Logic to compose and deduplicate identifier segments
3. **View Modifiers**: Extensions that apply the identifiers and manage container semantics

## Environment Propagation

When you apply `.a11yRoot("login")` or `.nestedAccessibilityIdentifier("button")` to a view, the following happens:

1. The current environment's `accessibilityPrefix` is read
2. The new identifier is composed with the prefix (if applicable)
3. The view's `.accessibilityIdentifier` is set to the composed value
4. If the view is a container, it's marked with `.accessibilityElement(children: .contain)`
5. The environment is updated with the new prefix for all child views

This ensures that all descendants automatically inherit the parent's prefix.

## Identifier Composition Rules

Identifiers are composed according to these rules:

1. If there's no prefix yet, the identifier is used as-is
2. If there's an existing prefix, the new identifier is appended with a dot separator
3. If the new identifier would create a duplicate suffix, the duplicate is eliminated

For example:
- Root: `"login"` + Child: `"button"` = `"login.button"`
- Root: `"login.button"` + Child: `"button"` = `"login.button"` (not `"login.button.button"`)

## Container Semantics

Any view that receives a nested accessibility identifier is automatically marked as a container with:

```swift
.accessibilityElement(children: .contain)
```

This ensures that the view hierarchy is properly represented in the accessibility tree, making UI testing more reliable.

## Button Behavior Caveat

SwiftUI `Button` views handle accessibility identifiers in a special way. The button's label (not the button itself) receives the identifier for VoiceOver purposes. However, UI tests can still locate the button using the composed identifier.

This means:
- VoiceOver will read the button's label text
- UI tests can find the button using the full hierarchical path

## Debug Support

When debugging accessibility identifiers, you can enable extra logging by defining both `DEBUG` and `NESTED_A11Y_DEBUG` compilation conditions. This will print information about identifier composition and environment updates to the console.

## Performance Considerations

The implementation is designed to be lightweight:
- String composition operations are minimal and efficient
- Environment propagation leverages SwiftUI's built-in mechanisms
- No additional view hierarchy or wrapper views are created

This ensures that using nested accessibility identifiers has negligible impact on your app's performance.