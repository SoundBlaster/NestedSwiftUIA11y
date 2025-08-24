import SwiftUI

/// A SwiftUI environment key that stores the current accessibility identifier prefix.
///
/// This key is used internally by the nested accessibility identifier system to
/// propagate prefixes down the view hierarchy.
struct AccessibilityPrefixKey: EnvironmentKey {
    /// The default value is an empty string, indicating no prefix is set.
    static let defaultValue: String = ""
}

extension EnvironmentValues {
    /// The current accessibility identifier prefix that will be applied to child views.
    ///
    /// This value is automatically managed by the `nestedAccessibilityIdentifier` and `a11yRoot`
    /// modifiers, and you typically don't need to access it directly.
    ///
    /// - Note: The value represents the fully composed path up to the current view in the hierarchy.
    public var accessibilityPrefix: String {
        get { self[AccessibilityPrefixKey.self] }
        set { self[AccessibilityPrefixKey.self] = newValue }
    }
}
