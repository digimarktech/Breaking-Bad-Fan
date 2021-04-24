//
//  CarouselCardView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import SwiftUI

/// The card used in the carousel.
struct CarouselCardView: View {
    
    /// The name of the image to display.
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300)
            .clipped()
            .cornerRadius(20)
            .padding(24)
    }
}
