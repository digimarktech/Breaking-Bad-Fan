//
//  HomeViewModel.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation
import Combine
import SwiftUI

/// An `ObservableObject` that is used to drive the data for the `HomeView`.
final class HomeViewModel: ObservableObject {
    
    /// The characters returned from the api request.
    @Published var characters = [ShowCharacter]()
    
    /// An error that can be displayed.
    @Published private(set) var displayError: DisplayError?
    
    /// Whether or not we are displaying an alert.
    ///
    /// This will be true if our `displayError ` has a value.
    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.displayError != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.displayError = nil
        })
    }
    
    private var apiService = APIService()
    private var cancellable: AnyCancellable?
    
    /// Request characters from the api.
    func getCharacters() {
        cancellable = apiService.getCharacters(CharacterEndpoint())
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.displayError = DisplayError(title: "Error", message: error.localizedDescription)
                case .finished:
                break
                }
            } receiveValue: { [weak self] characters in
                self?.characters = characters
            }
    }
}
