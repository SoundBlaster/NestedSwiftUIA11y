import XCTest

@testable import NestedA11yIDs

final class CompositionTests: XCTestCase {
    func testBasicComposition() {
        // Test basic prefix + identifier composition
        XCTAssertEqual(
            IDComposer.compose(prefix: "login", identifier: "button"),
            "login.button",
            "Basic composition should join with a dot"
        )
    }

    func testEmptyPrefix() {
        // Test with empty prefix
        XCTAssertEqual(
            IDComposer.compose(prefix: "", identifier: "button"),
            "button",
            "Empty prefix should return just the identifier"
        )
    }

    func testEmptyIdentifier() {
        // Test with empty identifier
        XCTAssertEqual(
            IDComposer.compose(prefix: "login", identifier: ""),
            "login",
            "Empty identifier should return just the prefix"
        )
    }

    func testDuplicateSuffix() {
        // Test duplicate suffix handling
        XCTAssertEqual(
            IDComposer.compose(prefix: "login.button", identifier: "button"),
            "login.button",
            "Duplicate suffix should be deduplicated"
        )
    }

    func testPartialDuplicateSuffix() {
        // Test partial duplicate suffix
        XCTAssertEqual(
            IDComposer.compose(prefix: "login.form", identifier: "form.field"),
            "login.form.field",
            "Partial duplicates should be properly handled"
        )
    }

    func testMultipleLevelComposition() {
        // Test composition across multiple levels
        let level1 = IDComposer.compose(prefix: "", identifier: "login")
        let level2 = IDComposer.compose(prefix: level1, identifier: "form")
        let level3 = IDComposer.compose(prefix: level2, identifier: "username")

        XCTAssertEqual(
            level3, "login.form.username", "Multi-level composition should work correctly")
    }

    func testDotInIdentifier() {
        // Test handling identifiers that contain dots
        XCTAssertEqual(
            IDComposer.compose(prefix: "login", identifier: "user.name"),
            "login.user.name",
            "Dots in identifiers should be preserved"
        )
    }

    func testDeduplicationWithDotInIdentifier() {
        // Test deduplication with dots in identifiers
        XCTAssertEqual(
            IDComposer.compose(prefix: "login.user", identifier: "user.name"),
            "login.user.name",
            "Deduplication should handle identifiers with dots"
        )
    }

    func testComplexDeduplication() {
        // Test more complex deduplication scenarios
        XCTAssertEqual(
            IDComposer.compose(prefix: "app.settings.account", identifier: "account.details"),
            "app.settings.account.details",
            "Complex deduplication should work correctly"
        )
    }

    func testComplexDeduplicationWithExactMatch() {
        // Test complex deduplication with exact match of last component
        XCTAssertEqual(
            IDComposer.compose(prefix: "app.settings.account.details", identifier: "details"),
            "app.settings.account.details",
            "Complex deduplication with exact match should work correctly"
        )
    }
}
