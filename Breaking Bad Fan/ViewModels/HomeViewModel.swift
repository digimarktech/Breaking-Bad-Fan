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
    @Published private(set) var apiError: APIError?
    
    /// Whether or not we are loading data from the network.
    @Published var isLoading: Bool = false
    
    /// Whether or not we are displaying an alert.
    ///
    /// This will be true if our `displayError ` has a value.
    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.apiError != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.apiError = nil
        })
    }
    
    private var apiService = APIService()
    private var cancellable: AnyCancellable?
    
    /// Request characters from the api.
    func getCharacters() {
        isLoading = true
        cancellable = apiService.getCharacters(CharacterEndpoint())
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error as APIError):
                    switch error {
                    case .failedToDecode(let errorDetails):
                        self?.apiError = .failedToDecode(errorDetails)
                    case .responseFailed:
                        self?.apiError = .responseFailed
                    }
                case .finished:
                    break
                default:
                    break
                }
            } receiveValue: { [weak self] characters in
                self?.characters = characters
            }
    }
}
