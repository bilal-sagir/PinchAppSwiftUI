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
    @State private var imageOffset: CGSize = .zero
    // MARK: - FUNCTIONS
    
    func resetImageState() { // not used
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    // MARK: - CONTENT
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
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
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        withAnimation(.spring()) {
                            imageScale = imageScale == 1 ? 5 : 1
                            imageOffset = .zero
                        }
                    })
                    // MARK: - 2. DRAG IMAGE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    withAnimation(.linear(duration: 0.5)) {
                                        imageScale = 1
                                        imageOffset = .zero
                                    }
                                }
                            })
                    )
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
            
            // MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
        } //: NAVIGATION
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
