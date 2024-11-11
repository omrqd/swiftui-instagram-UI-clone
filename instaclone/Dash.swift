//
//  Dash.swift
//  instaclone
//
//  Created by Omar Said on 11/11/2024.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack {
            // Messages Header
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Text("Messages")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                        .font(.title2)
                }
            }
            .padding()

            // Messages List
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10) { index in
                        HStack {
                            Circle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(width: 56, height: 56)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("user\(index + 1)")
                                    .font(.system(size: 15, weight: .semibold))
                                Text("Sent you a message • 2h")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct Dash: View {
    @State private var likedPosts: Set<Int> = []
    @State private var showLikeEffect: Bool = false
    @State private var likeEffectScale: CGFloat = 1.0
    @State private var messageCount: Int = 0
    @State private var selectedTab: Int = 0
    @State private var showMessages: Bool = false
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    // App Bar
                    HStack {
                        Text("Instagram")
                            .font(.custom("Instagram Sans", size: 24))
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showMessages.toggle()
                            }
                        }) {
                            Image(systemName: "paperplane")
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            // Add Story Circle
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(width: 70, height: 70)
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 25, height: 25)
                                        )
                                        .overlay(
                                            Circle()
                                                .stroke(Color.blue, lineWidth: 2)
                                                .frame(width: 25, height: 25)
                                        )
                                        .offset(x: 25, y: 25)
                                }
                                Text("Your Story")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }

                            // Story Circles
                            ForEach(0..<10) { index in
                                VStack {
                                    Circle()
                                        .strokeBorder(
                                            LinearGradient(
                                                colors: [.purple, .red, .orange],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 2
                                        )
                                        .frame(width: 72, height: 72)
                                        .overlay(
                                            Circle()
                                                .fill(Color.gray.opacity(0.1))
                                                .frame(width: 68, height: 68)
                                        )
                                    Text("Person \(index + 1)")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding()
                    }

                    Divider()

                    // Posts Feed
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(0..<5) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    // User Info
                                    HStack {
                                        Circle()
                                            .fill(Color.gray.opacity(0.1))
                                            .frame(width: 32, height: 32)
                                        Text("user\(index + 1)")
                                            .font(.system(size: 14, weight: .semibold))
                                        Spacer()
                                        Button(action: {}) {
                                            Image(systemName: "ellipsis")
                                        }
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)

                                    // Post Image
                                    ZStack {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity)
                                            .background(Color.gray.opacity(0.1))
                                            .onTapGesture(count: 2) {
                                                if likedPosts.contains(index) {
                                                    likedPosts.remove(index)
                                                } else {
                                                    likedPosts.insert(index)
                                                    withAnimation(.easeInOut(duration: 0.5)) {
                                                        showLikeEffect = true
                                                        likeEffectScale = 1.5
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                        withAnimation(.easeInOut(duration: 0.5)) {
                                                            showLikeEffect = false
                                                            likeEffectScale = 1.0
                                                        }
                                                    }
                                                }
                                            }

                                        if showLikeEffect && likedPosts.contains(index) {
                                            Image(systemName: "heart.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(.white)
                                                .opacity(0.8)
                                                .scaleEffect(likeEffectScale)
                                                .transition(.scale)
                                        }
                                    }

                                    // Action Buttons
                                    HStack(spacing: 16) {
                                        Button(action: {
                                            if likedPosts.contains(index) {
                                                likedPosts.remove(index)
                                            } else {
                                                likedPosts.insert(index)
                                            }
                                        }) {
                                            Image(systemName: likedPosts.contains(index) ? "heart.fill" : "heart")
                                                .font(.title2)
                                                .foregroundColor(likedPosts.contains(index) ? .red : .primary)
                                        }
                                        Button(action: {}) {
                                            Image(systemName: "message")
                                                .font(.title2)
                                        }
                                        Button(action: {}) {
                                            Image(systemName: "paperplane")
                                                .font(.title2)
                                        }
                                        Spacer()
                                        Button(action: {}) {
                                            Image(systemName: "bookmark")
                                                .font(.title2)
                                        }
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)

                                    // Likes Count
                                    Text("\(Int.random(in: 1...1000)) likes")
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.horizontal, 12)

                                    // Caption
                                    HStack {
                                        Text("user\(index + 1)")
                                            .font(.system(size: 14, weight: .semibold)) +
                                        Text(" This is a sample caption for the post")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 8)
                                }
                                .background(Color.white)

                                Divider()
                            }
                        }
                    }

                    Spacer()

                    // Instagram-style Navigation Bar
                    HStack {
                        Button(action: {
                            selectedTab = 0
                        }) {
                            Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                .font(.title2)
                                .foregroundColor(selectedTab == 0 ? .black : .black.opacity(0.5))
                        }
                        Spacer()
                        Button(action: {
                            selectedTab = 1
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(selectedTab == 1 ? .black : .black.opacity(0.5))
                        }
                        Spacer()
                        Button(action: {
                            selectedTab = 2
                        }) {
                            Image(systemName: "plus.app")
                                .font(.title2)
                                .foregroundColor(selectedTab == 2 ? .black : .black.opacity(0.5))
                        }
                        Spacer()
                        Button(action: {
                            selectedTab = 3
                        }) {
                            Image(systemName: "heart")
                                .font(.title2)
                                .foregroundColor(selectedTab == 3 ? .black : .black.opacity(0.5))
                        }
                        Spacer()
                        Button(action: {
                            selectedTab = 4
                        }) {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.caption)
                                        .foregroundColor(.black.opacity(0.5))
                                )
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .overlay(
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 0.3)
                            .background(Color.gray.opacity(0.3)),
                        alignment: .top
                    )
                }
                .frame(width: geometry.size.width)

                if showMessages {
                    MessagesView()
                        .frame(width: geometry.size.width)
                        .transition(.move(edge: .trailing))
                }
            }
            .offset(x: showMessages ? -geometry.size.width : 0)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold = geometry.size.width * 0.25
                        if value.translation.width > threshold {
                            withAnimation {
                                showMessages = true
                            }
                        } else if value.translation.width < -threshold && showMessages {
                            withAnimation {
                                showMessages = false
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    Dash()
}
