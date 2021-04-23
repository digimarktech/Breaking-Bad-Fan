//
//  CharacterEndpoint.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// The `Endpoint` used to fetch characters from the api.
struct CharacterEndpoint: Endpoint {
    
    var baseURL: URL {
        return URL(string: "https://www.breakingbadapi.com/api")!
    }
    
    var path: String {
        return "/characters"
    }
}
