//
//  CarouselCardView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import SwiftUI

struct CarouselCardView: View {
    var color: Color
    var handler: () -> Void
    var body: some View {
        Button(action: {
            handler()
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .padding(24)
        })
    }
}
