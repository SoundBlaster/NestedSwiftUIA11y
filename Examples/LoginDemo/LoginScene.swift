import NestedA11yIDs
import SwiftUI

struct LoginScene: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false

    var body: some View {
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
                    #if os(iOS)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    #endif
                    .nestedAccessibilityIdentifier("email")

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .nestedAccessibilityIdentifier("password")

                if isRegistering {
                    SecureField("Confirm Password", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .nestedAccessibilityIdentifier("confirmPassword")
                }

                Button(isRegistering ? "Register" : "Sign In") {
                    print("Handle login/registration")
                }
                .nestedAccessibilityIdentifier("button")
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)

                Button(action: {
                    print("Handle forgot password")
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
        // Root identifier for the entire login scene
        .a11yRoot(isRegistering ? "registration" : "login")
    }
}

#Preview {
    LoginScene()
}
