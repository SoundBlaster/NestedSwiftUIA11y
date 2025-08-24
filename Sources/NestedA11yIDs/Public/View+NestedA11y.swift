import SwiftUI

extension View {
    /// Applies a nested accessibility identifier to the view.
    ///
    /// This modifier applies an accessibility identifier that is automatically composed with any
    /// parent identifiers in the view hierarchy. It also marks the view as an accessibility container
    /// and updates the environment for child views.
    ///
    /// Example:
    /// ```swift
    /// VStack {
    ///     Text("Welcome")
    ///         .nestedAccessibilityIdentifier("title")
    ///
    ///     Button("Sign In") {
    ///         // Action
    ///     }
    ///     .nestedAccessibilityIdentifier("button")
    /// }
    /// .a11yRoot("login")
    /// ```
    ///
    /// This will generate accessibility identifiers of `login.title` and `login.button`.
    ///
    /// - Parameter id: The identifier to apply to this view, which will be composed with any
    ///   parent identifiers
    /// - Returns: A view with the composed accessibility identifier applied
    public func nestedAccessibilityIdentifier(_ id: String) -> some View {
        modifier(AccessibilityIdentifierModifier(id))
    }

    /// Sets a root accessibility identifier for a view hierarchy.
    ///
    /// This modifier sets the base identifier for a component or screen, which will be used as
    /// the prefix for all child views that use `nestedAccessibilityIdentifier`. It also marks
    /// the view as an accessibility container.
    ///
    /// Example:
    /// ```swift
    /// LoginView()
    ///     .a11yRoot("login")
    /// ```
    ///
    /// - Parameter id: The root identifier for this view hierarchy
    /// - Returns: A view with the root accessibility identifier applied
    public func a11yRoot(_ id: String) -> some View {
        modifier(RootAccessibilityIdentifierModifier(id))
    }
}
