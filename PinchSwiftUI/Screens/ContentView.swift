//
//  ContentView.swift
//  PinchSwiftUI
//
//  Created by Bilal on 24.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    // MARK: - FUNCTIONS
    // MARK: - CONTENT
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(
                        .rect(cornerRadii: RectangleCornerRadii(topLeading: 10,
                                                                       bottomLeading: 10,
                                                                       bottomTrailing: 10,
                                                                       topTrailing: 10))
                    )
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                    // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        withAnimation(.spring()) {
                            imageScale = imageScale == 1 ? 5 : 1
                        }
                    })
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
        } //: NAVIGATION
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
