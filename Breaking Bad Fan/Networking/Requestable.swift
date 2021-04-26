//
//  Requestable.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import Combine
import Foundation

/// Represents a type that can execute requests.
protocol Requestable {
    
    /// The `URLSession` being used for this request.
    var urlSession: URLSession { get }
    
    /// Performs a fetch of the model type specified and returns an `AnyPublisher` containing that model type..
    /// - Parameters:
    ///   - request: Contains the data necessary to perform the request.
    ///   - type: The model type that will be decoded when the request completes.
    ///   - queue: The queue to make the request on. Defaults to `main`.
    ///   - retries: The number of times to retry the request if it fails. Defaults to `0`.
    func fetch<Model: Decodable>(_ request: URLRequest, withType type: Model.Type, queue: DispatchQueue, retries: Int) -> AnyPublisher<Model, Error>
}

extension Requestable {
    
    func fetch<Model: Decodable>(_ request: URLRequest, withType type: Model.Type, queue: DispatchQueue = .main, retries: Int = 0) -> AnyPublisher<Model, Error> {
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseFailed
                }
                return $0.data
            }
            .decode(type: Model.self, decoder: JSONDecoder())
            .mapError({ error in
                return process(error: error)
            })
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
    
    private func process(error: Error) -> Error {
        if let error = error as? DecodingError {
            var errorToReport = error.localizedDescription
            switch error {
            case .dataCorrupted(let context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) - (\(details))"
            case .keyNotFound(let key, let context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
            case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
            @unknown default:
                break
            }
            return APIError.failedToDecode(errorToReport)
        } else {
            return error
        }
    }
}
