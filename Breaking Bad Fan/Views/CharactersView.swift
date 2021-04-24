//
//  CharactersView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Characters")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
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
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 16)
                    }
                }
            }
        }.padding(.horizontal)
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
