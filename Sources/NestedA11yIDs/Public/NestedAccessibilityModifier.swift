import SwiftUI

/// A view modifier that applies hierarchical accessibility identifiers to views.
///
/// This modifier is used internally by the `nestedAccessibilityIdentifier` and `a11yRoot`
/// view extensions.
struct AccessibilityIdentifierModifier: ViewModifier {
    private let identifier: String
    @Environment(\.accessibilityPrefix) private var prefix

    /// Creates a new accessibility identifier modifier.
    /// - Parameter identifier: The identifier to apply, which will be composed with any existing prefix
    init(_ identifier: String) {
        self.identifier = identifier
    }

    func body(content: Content) -> some View {
        // Skip empty identifiers
        if identifier.isEmpty {
            return AnyView(content)
        }

        // Compose the full identifier
        let composedID = IDComposer.compose(prefix: prefix, identifier: identifier)

        #if DEBUG && NESTED_A11Y_DEBUG
            IDComposer.debugLog(prefix: prefix, identifier: identifier, result: composedID)
        #endif

        return AnyView(
            content
                // Apply the composed identifier
                .accessibilityIdentifier(composedID)
                // Mark as a container (improves accessibility tree for nested elements)
                .accessibilityElement(children: .contain)
                // Update the environment for child views
                .environment(\.accessibilityPrefix, composedID)
        )
    }
}

/// A view modifier that sets a root accessibility identifier.
///
/// This modifier is used internally by the `a11yRoot` view extension.
struct RootAccessibilityIdentifierModifier: ViewModifier {
    private let identifier: String

    /// Creates a new root accessibility identifier modifier.
    /// - Parameter identifier: The root identifier to apply
    init(_ identifier: String) {
        self.identifier = identifier
    }

    func body(content: Content) -> some View {
        // Skip empty identifiers
        if identifier.isEmpty {
            return AnyView(content)
        }

        return AnyView(
            content
                // Apply the identifier directly (no composition at root)
                .accessibilityIdentifier(identifier)
                // Mark as a container (improves accessibility tree for nested elements)
                .accessibilityElement(children: .contain)
                // Set the environment for child views
                .environment(\.accessibilityPrefix, identifier)
        )
    }
}
