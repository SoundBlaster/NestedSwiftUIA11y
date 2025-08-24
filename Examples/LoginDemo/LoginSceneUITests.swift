import NestedA11yIDs
import SwiftUI

// MARK: - UI Testing Extensions
extension LoginScene {
    /// This is a helper extension to demonstrate how to use the nested identifiers in UI tests

    /// Example UI test function that can be used to test the login flow
    static func uiTestLogin() -> String {
        """
        func testLoginFlow() {
            let app = XCUIApplication()
            app.launch()

            // Find elements using the composed identifiers
            let emailField = app.textFields["login.form.email"]
            let passwordField = app.secureTextFields["login.form.password"]
            let signInButton = app.buttons["login.form.button"]

            // Perform login actions
            emailField.tap()
            emailField.typeText("user@example.com")

            passwordField.tap()
            passwordField.typeText("password123")

            signInButton.tap()

            // Verify login was successful (add your own assertions)
        }
        """
    }

    /// Example UI test function that can be used to test the registration flow
    static func uiTestRegistration() -> String {
        """
        func testRegistrationFlow() {
            let app = XCUIApplication()
            app.launch()

            // Switch to registration mode
            app.buttons["login.footer.toggle"].tap()

            // Now identifiers have "registration" as the root
            let emailField = app.textFields["registration.form.email"]
            let passwordField = app.secureTextFields["registration.form.password"]
            let confirmPasswordField = app.secureTextFields["registration.form.confirmPassword"]
            let registerButton = app.buttons["registration.form.button"]

            // Perform registration actions
            emailField.tap()
            emailField.typeText("newuser@example.com")

            passwordField.tap()
            passwordField.typeText("newpassword123")

            confirmPasswordField.tap()
            confirmPasswordField.typeText("newpassword123")

            registerButton.tap()

            // Verify registration was successful (add your own assertions)
        }
        """
    }
}
