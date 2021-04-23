//
//  HomeViewModel.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

final class HomeViewModel: ObservableObject {
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
