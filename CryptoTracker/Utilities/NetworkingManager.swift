//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/15/24.
//

import Foundation
import Combine

// For generic code that we can reuse

// Use for downloading from URL
class NetworkingManager {

    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured."
            }
        }
    }
    
    // We use static because we will always use the same function. Without it, we'd have to initialize a URL when creating an instance of NetworkingManager.
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default)) // Subscribe on background thread
            .tryMap({ try handleURLResponse(output: $0, url: url) }) // try to Map on URL response to check if it's valid or not
            .receive(on: DispatchQueue.main) // Receive on main thread
            .eraseToAnyPublisher() // Wraps the publisher to an AnyPublisher type. The URLSession above is a deep nested publisher, so this will simplify and protect that specific type.
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<any Publishers.Decode<AnyPublisher<Data, any Error>, [CoinModel], JSONDecoder>.Failure>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }

    }
}
