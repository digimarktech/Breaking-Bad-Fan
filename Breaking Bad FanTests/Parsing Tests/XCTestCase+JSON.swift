//
//  XCTestCase+JSON.swift
//  Breaking Bad FanTests
//
//  Created by Marc Aupont on 4/23/21.
//

import XCTest

/// Adds helper methods to `XCTestCase` for dealing with JSON.
extension XCTestCase {
    
    /// JSON decoder to use for decoding tests.
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    /// JSON encoder to use for encoding tests.
    static let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        return jsonEncoder
    }()
    
    /// Returns a serialized JSON object from a file within the bundle.
    ///
    /// - Parameter fileName: The name of the JSON file, without the extension.
    /// - Returns: A JSON object if it can be created from the file on disk, otherwise `nil`.
    static func jsonObject(fromfileNamed fileName: String) -> Data? {
        let bundle = Bundle(for: self)
        
        guard let jsonURL = bundle.url(forResource: fileName, withExtension: "json") else { return nil }
        return try? Data(contentsOf: jsonURL)
    }
}
