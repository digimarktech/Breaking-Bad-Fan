//
//  SpinnerView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/26/21.
//

import SwiftUI

/// A `View` that has a spinner that displays when the network is fetching data.
struct SpinnerView: View {
    
    /// Whether or not the view is animating
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 200)
            
            ZStack {
                Color.gray.opacity(0.5)
                
                Circle()
                    .trim(from: 0.2, to: 1)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round
                        )
                    )
                    .frame(width: 50, height: 50)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 1)
                            .repeatForever(autoreverses: false)
                    )
            }
            .frame(width: 80, height: 80)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 5)
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
            .onAppear {
                self.isAnimating = true
            }
        }
    }
}
