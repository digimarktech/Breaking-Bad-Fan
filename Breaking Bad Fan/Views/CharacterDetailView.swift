//
//  CharacterDetailView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/22/21.
//

import SwiftUI
import Kingfisher

/// Displays detail information about a character
struct CharacterDetailView: View {

    @Environment(\.presentationMode) var presentationMode
    
    /// The character being displayed.
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
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(character.name)
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.white)
                        DetailRowView(label: "Real name: ", value: character.realName)
                        DetailRowView(label: "Nickname: ", value: character.nickname)
                        DetailRowView(label: "Status: ", value: character.status)
                        DetailRowView(label: "Birthday: ", value: character.birthday)
                        DetailListRowView(label: "Occupation: ", items: character.occupation)
                        DetailListRowView(label: "Seasons: ", items: character.seasons.map { "\($0)" })
                    }
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width)
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
}

//struct CharacterDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetailView()
//    }
//}
