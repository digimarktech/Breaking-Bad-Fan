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
                    HStack {
                        Text("Real name: ")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(character.realName)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Nickname: ")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(character.nickname)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Status: ")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(character.status)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Birthday: ")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(character.birthday)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading) {
                        Text("Occupation: ")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.bottom, 2)
                        ForEach(character.occupation, id: \.self) { occupation in
                            HStack {
                                Text("∗ ")
                                Text(occupation)
                            }
                            .foregroundColor(.white)
                            .font(.subheadline)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Seasons: ")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.bottom, 2)
                        ForEach(character.seasons, id: \.self) { season in
                            HStack {
                                Text("∗ ")
                                Text("\(season)")
                            }
                            .foregroundColor(.white)
                            .font(.subheadline)
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
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .font(.title)
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
