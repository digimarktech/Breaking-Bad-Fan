//
//  LocationError.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// Used to display location error alert.
struct LocationError {
    
    /// The title of the alert.
    var title: String
    
    /// The message of the alert.
    var message: String
}

// MARK: - Identifiable

extension LocationError: Identifiable {
    
    /// Unique ID used for identifable purposes
    var id: String {
        return message
    }
}
