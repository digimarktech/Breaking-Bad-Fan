//
//  LocationError.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// An error based on location related permissions.
enum LocationPermissionError: Error, LocalizedError {
    
    /// Error where user has denied location permissions.
    case denied
    
    /// Error where user has restricted permissions.
    case restricted
    
    /// Unknown error type.
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .denied:
            return "Permissions Denied"
        case .restricted:
            return "Permissions Restricted"
        case .unknown:
            return "Unknown Error"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .denied:
            return "Please allow location permissions in settings."
        case .restricted:
            return "Location permissions are restricted"
        case .unknown:
            return "Unable to process location at this time."
        }
    }
}
