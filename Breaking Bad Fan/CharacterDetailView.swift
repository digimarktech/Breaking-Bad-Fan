//
//  CharacterDetailView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/22/21.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {

    @Environment(\.presentationMode) var presentationMode
    var character: ShowCharacter
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical) {
                GeometryReader { reader in
                    KFImage(character.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                    
                }
                .frame(height: 480)
                VStack(alignment: .leading, spacing: 15) {
                    Text(character.name)
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                    HStack(spacing: 15) {
                        ForEach(1...5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                        }
                    }
                    Text("Some sample text that I can replace later")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    
                    Text(tempText)
                        .padding(.top, 10)
                        .foregroundColor(.white)
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color.black)
                .cornerRadius(20)
                .offset(y: -35)
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            Button("Test") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .offset(x: 20, y: 20)
        }
        
    }
    
    var tempText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
}

//struct CharacterDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetailView()
//    }
//}
