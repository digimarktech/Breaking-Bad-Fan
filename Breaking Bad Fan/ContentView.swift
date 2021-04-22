//
//  ContentView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/18/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var selected: ShowCharacter = ShowCharacter(id: 1, name: "Walter White", birthday: "09-07-1958", occupation: ["High School Chemistry Teacher", "Meth King Pin"], imageURL: URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!, status: "Presumed dead", nickname: "Heisenberg", seasons: [1,2,3,4,5], realName: "Bryan Cranston")
    @State var show = false
    @Namespace var characterImageNameSpace
    
    let columns = Array(repeating: GridItem(.flexible(minimum: 100)), count: 2)
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    InfinitePageView(pages: [
                        CardView(color: .red) {
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
                                ForEach(viewModel.characters) { character in
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
                .background(LinearGradient(gradient: Gradient(colors: [.black, .green]), startPoint: .leading, endPoint: .trailing))
                .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                self.viewModel.getCharacters()
            }
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

final class ViewModel: ObservableObject {
    @Published var characters = [ShowCharacter]()
    
    func getCharacters() {
        URLSession.shared.dataTask(with: URL(string: "https://www.breakingbadapi.com/api/characters")!) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            if let characters = try? JSONDecoder().decode([ShowCharacter].self, from: data) {
                DispatchQueue.main.async {
                    self.characters = characters
                }
            }
        }.resume()
    }
}

struct ShowCharacter: Codable, Identifiable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let imageURL: URL
    let status: String
    let nickname: String
    let seasons: [Int]
    let realName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case imageURL = "img"
        case status
        case nickname
        case seasons = "appearance"
        case realName = "portrayed"
    }
}
