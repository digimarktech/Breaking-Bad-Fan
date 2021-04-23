//
//  Endpoint.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Foundation

/// Represents an endpoint that can be used to fetch data
protocol Endpoint {
    
    /// The base `URL` for the endpoint.
    var baseURL: URL { get }
    
    /// The specific path.
    var path: String { get }
}

extension Endpoint {
    
    // Default properties for any Endpoint.
    
    /// The `URLComponents` structure for the full `baseURL` and `path`
    var urlComponents: URLComponents {
        var components = URLComponents(string: baseURL.absoluteString)!
        components.path = path
        return components
    }
    
    /// The complete `URLRequest` for this endpoint
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
