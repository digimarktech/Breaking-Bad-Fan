//
//  APIService.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation
import Combine

/// Service used to make network requests.
final class APIService: Requestable {
    
    /// The `URLSession` object for this service.
    var urlSession: URLSession
    
    /// Creates a `APIService`.
    /// - Parameter configuration: The configuration for the `URLSession`.
    init(configuration: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: configuration)
    }
    
    /// Fetches characters from the API
    /// - Parameter endpoint: The specific endpoint that returns an array of `ShowCharacter`'s
    /// - Returns: An `AnyPublisher` that contains the characters or an error.
    func getCharacters(_ endpoint: CharacterEndpoint) -> AnyPublisher<[ShowCharacter], Error> {
        return fetch(endpoint.request, withType: [ShowCharacter].self)
    }
}
