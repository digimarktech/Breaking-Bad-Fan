//
//  ContentView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/18/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView {
            InfinitePageView(pages: [
                CardView(color: .red){
                    print("Red was pressed")
                },
                CardView(color: .green) {
                    print("Green was pressed")
                },
                CardView(color: .gray) {
                    print("Gray was presed")
                }
            ])
            .frame(height: 300)
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100)), GridItem(.flexible(minimum: 100))], content: {
                ForEach(0 ..< 62) { item in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green)
                        .frame(height: 100)
                }.padding(.horizontal, 10)
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
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
