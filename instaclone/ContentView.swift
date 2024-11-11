//
//  ContentView.swift
//  instaclone
//
//  Created by Omar Said on 11/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPage = 0
    @State private var showLogin = false

    let splashPages = [
        SplashPage(image: "photo.fill", title: "Share Your Moments", description: "Capture and share your favorite memories with friends and family"),
        SplashPage(image: "heart.fill", title: "Connect With Others", description: "Like, comment and interact with posts from people around the world"),
        SplashPage(image: "message.fill", title: "Stay Connected", description: "Send messages and stay in touch with your loved ones")
    ]

    var body: some View {
        if showLogin {
            LoginView()
        } else {
            TabView(selection: $currentPage) {
                ForEach(0..<splashPages.count, id: \.self) { index in
                    VStack(spacing: 20) {
                        Image(systemName: splashPages[index].image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.purple)
                            .padding()

                        Text(splashPages[index].title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Text(splashPages[index].description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 32)

                        if index == splashPages.count - 1 {
                            Button(action: {
                                showLogin = true
                            }) {
                                Text("Start Now")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 50)
                                    .background(Color.purple)
                                    .cornerRadius(25)
                            }
                            .padding(.top, 50)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct SplashPage {
    let image: String
    let title: String
    let description: String
}

#Preview {
    ContentView()
}
