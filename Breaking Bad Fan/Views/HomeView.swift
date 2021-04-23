//
//  HomeView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/18/21.
//

import SwiftUI
import Kingfisher

/// Represents the home screen of the app.
struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    InfinitePageView(pages: [
                        CarouselCardView(color: .red) {
                            print("Red was pressed")
                        },
                        CarouselCardView(color: .green) {
                            print("Green was pressed")
                        },
                        CarouselCardView(color: .gray) {
                            print("Gray was presed")
                        }
                    ])
                    .frame(height: 300)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Characters")
                                .font(.title)
                                .fontWeight(.medium)
                            Spacer()
                            Button("View All") {
                                print("View all was pressed")
                            }
                        }
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 24) {
                                ForEach(homeViewModel.characters) { character in
                                    VStack(alignment: .leading) {
                                        NavigationLink(destination: CharacterDetailView(character: character)) {
                                            KFImage(character.imageURL)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200, height: 300)
                                                .clipped()
                                                .cornerRadius(10)
                                        }
                                        Text(character.name)
                                            .font(.subheadline)
                                    }
                                    .padding(.bottom, 16)
                                }
                            }
                        }
                    }.padding(.horizontal)
                    .navigationBarTitle("Breaking Bad")
                    .navigationBarItems(trailing: Button(action: {
                        print("Location pressed")
                    }, label: {
                        Image(systemName: "location")
                    }))
                    
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                self.homeViewModel.getCharacters()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
