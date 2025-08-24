import Foundation

/// Utility for composing and deduplicating hierarchical accessibility identifiers.
enum IDComposer {

    /// Composes a new identifier by joining the prefix and identifier with a dot separator.
    /// Deduplicates the identifier if it would create a duplicate suffix.
    ///
    /// - Parameters:
    ///   - prefix: The current prefix (may be empty)
    ///   - identifier: The new identifier to append
    /// - Returns: A composed identifier that follows the dot-separated hierarchy rules
    static func compose(prefix: String, identifier: String) -> String {
        // Empty identifier case - just return the prefix
        guard !identifier.isEmpty else { return prefix }

        // Empty prefix case - use the identifier as-is
        guard !prefix.isEmpty else { return identifier }

        // Check for duplicate suffix
        if let lastComponent = prefix.components(separatedBy: ".").last,
            identifier == lastComponent || identifier.hasPrefix("\(lastComponent).")
        {
            // If the identifier exactly matches the last component of the prefix,
            // or it starts with the last component followed by a dot,
            // just return the prefix to avoid duplication
            if identifier == lastComponent {
                return prefix
            }

            // If the identifier starts with the last component followed by a dot,
            // append only the non-duplicated part
            if identifier.hasPrefix("\(lastComponent).") {
                let suffixStartIndex = identifier.index(
                    identifier.startIndex, offsetBy: lastComponent.count + 1)
                let suffix = String(identifier[suffixStartIndex...])
                return "\(prefix).\(suffix)"
            }
        }

        // Standard case - join with dot
        return "\(prefix).\(identifier)"
    }

    #if DEBUG && NESTED_A11Y_DEBUG
        /// Logs information about the composition process when debug flags are enabled.
        ///
        /// - Parameters:
        ///   - prefix: The current prefix
        ///   - identifier: The new identifier
        ///   - result: The composed result
        static func debugLog(prefix: String, identifier: String, result: String) {
            print("[NestedA11yIDs] Composed: '\(prefix)' + '\(identifier)' = '\(result)'")
        }
    #endif
}
