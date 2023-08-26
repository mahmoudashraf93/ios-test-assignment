//
//  NetworkError.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

enum NetworkError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No response"
        case .unauthorized:
            return "Session expired"
        case .unexpectedStatusCode:
            return "Unexpected status code"
        default:
            return "Unknown error"
        }
    }
}
