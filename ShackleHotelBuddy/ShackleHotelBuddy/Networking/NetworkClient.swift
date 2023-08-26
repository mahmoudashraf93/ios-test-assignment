//
//  NetworkClient.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

protocol Requestable {
    func sendRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class NetworkClient: Requestable {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Sends a API request. If successful, decodes a JSON response and returns an object. Else, returns a NetworkError.
    ///
    /// - Parameter endpoint: The enpoint of the request
    ///
    /// - Returns: A Result type with a generic object and a NetworkError as associated values
    func sendRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let urlRequest = getURLRequest(endpoint) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }
        switch response.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkError.decode
            }
            return decodedResponse
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.unexpectedStatusCode
        }

    }

    private func getURLRequest(_ endpoint: Endpoint) -> URLRequest? {
        guard let url = endpoint.getURL() else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        for (key, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        return request
    }
}
