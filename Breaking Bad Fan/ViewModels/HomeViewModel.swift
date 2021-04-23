//
//  HomeViewModel.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation
import Combine

/// An `ObservableObject` that is used to drive the data for the `HomeView`.
final class HomeViewModel: ObservableObject {
    
    /// The characters returned from the api request.
    @Published var characters = [ShowCharacter]()
    
    private var apiService = APIService()
    private var cancellable: AnyCancellable?
    
    /// Request characters from the api.
    func getCharacters() {
        cancellable = apiService.getCharacters(CharacterEndpoint())
            .sink { error in
                switch error {
                case .failure:
                    // handle error case
                break
                case .finished:
                    // handle finished case
                break
                }
            } receiveValue: { [weak self] characters in
                self?.characters = characters
            }
    }
}
