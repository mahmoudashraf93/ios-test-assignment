//
//  URLSessionMock.swift
//  ShackleHotelBuddyTests
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation
@testable import ShackleHotelBuddy

class URLSessionMock: URLSessionProtocol {
    var result: (Data, URLResponse)? = nil
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }

        guard let result else {
            fatalError("Expected result")
        }

        return result
    }
}
