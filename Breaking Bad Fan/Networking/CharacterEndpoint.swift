//
//  CharacterEndpoint.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// The `Endpoint` used to fetch characters from the api.
struct CharacterEndpoint: Endpoint {
    
    var baseURL: String {
        return "https://www.breakingbadapi.com"
    }
    
    var path: String {
        return "/api/characters"
    }
}
