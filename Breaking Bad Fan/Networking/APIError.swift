//
//  APIError.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// Represents the various errors that occur when interacting with the API.
enum APIError: Error, LocalizedError {
    
    /// The response coming back from the server failed.
    case responseFailed
    
    /// Unable to decode the json coming back from the server.
    case failedToDecode(error: String)
    
    var errorDescription: String? {
        switch self {
        case .responseFailed:
            return "Bad response received from the server."
        case .failedToDecode:
            return "Unable to decode"
        }
    }
}
