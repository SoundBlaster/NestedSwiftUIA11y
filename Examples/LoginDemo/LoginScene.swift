import NestedA11yIDs
import SwiftUI

struct LoginScene: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header section
                VStack(spacing: 10) {
                    Image(systemName: "lock.shield")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .nestedAccessibilityIdentifier("logo")

                    Text(isRegistering ? "Create Account" : "Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .nestedAccessibilityIdentifier("title")

                    Text(isRegistering ? "Register to get started" : "Sign in to continue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .nestedAccessibilityIdentifier("subtitle")
                }
                .nestedAccessibilityIdentifier("header")

                // Form section
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .nestedAccessibilityIdentifier("email")

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .nestedAccessibilityIdentifier("password")

                    if isRegistering {
                        SecureField("Confirm Password", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .nestedAccessibilityIdentifier("confirmPassword")
                    }

                    Button(action: {
                        // Handle login/registration
                    }) {
                        Text(isRegistering ? "Register" : "Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .nestedAccessibilityIdentifier("button")

                    Button(action: {
                        // Handle forgot password
                    }) {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .nestedAccessibilityIdentifier("forgotPassword")
                }
                .padding(.horizontal)
                .nestedAccessibilityIdentifier("form")

                Spacer()

                // Footer section
                VStack {
                    Button(action: {
                        withAnimation {
                            isRegistering.toggle()
                        }
                    }) {
                        Text(
                            isRegistering
                                ? "Already have an account? Sign In"
                                : "Don't have an account? Register"
                        )
                        .foregroundColor(.blue)
                    }
                    .nestedAccessibilityIdentifier("toggle")

                    Text("© 2023 NestedA11yIDs Demo")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 5)
                        .nestedAccessibilityIdentifier("copyright")
                }
                .nestedAccessibilityIdentifier("footer")
            }
            .padding()
            .navigationBarHidden(true)
            // Root identifier for the entire login scene
            .a11yRoot(isRegistering ? "registration" : "login")
        }
    }
}

struct LoginDemo_Previews: PreviewProvider {
    static var previews: some View {
        LoginScene()
    }
}

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
