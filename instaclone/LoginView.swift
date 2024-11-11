//
//  LoginView.swift
//  instaclone
//
//  Created by Omar Said on 11/11/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToDash = false

    var body: some View {
        VStack(spacing: 20) {
            // Logo
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.purple)
                .padding(.top, 60)

            Text("InstaClone")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)

            // Input fields
            VStack(spacing: 15) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            .padding(.top, 30)

            // Login button
            Button(action: {
                navigateToDash = true
            }) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.purple)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            .fullScreenCover(isPresented: $navigateToDash) {
                Dash()
            }

            Spacer()

            // Sign up link
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                Button(action: {
                    // Handle sign up navigation
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                }
            }
            .padding(.bottom, 10)

            // Sign in with Apple/Google
            VStack(spacing: 15) {
                Button(action: {
                    // Handle Apple sign in
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                        Text("Sign in with Apple")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(25)
                    .padding(.horizontal)
                }

                Button(action: {
                    // Handle Google sign in
                }) {
                    HStack {
                        Image(systemName: "g.circle.fill")
                        Text("Sign in with Google")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.red)
                    .cornerRadius(25)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    LoginView()
}
