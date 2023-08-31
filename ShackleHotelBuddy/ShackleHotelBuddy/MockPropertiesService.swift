//
//  MockPropertiesService.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import Foundation

struct MockPropertiesService: PropertiesServiceProtocol {
    let expectedError: Error?
    let propertyDetailResponse: Property?
    let propertiesResponse: PropertiesResponse?

    func fetchProperties(with parameters: ListParameters) async throws -> PropertiesResponse {
        if let propertiesResponse {
            return propertiesResponse
        }

        guard let expectedError else {
            fatalError("No paths defined should either throw or return a value")
        }

        throw expectedError
    }

    func propertyDetail(for propertyID: String) async throws -> Property {
        if let propertyDetailResponse {
            return propertyDetailResponse
        }

        guard let expectedError else {
            fatalError("No paths defined should either throw or return a value")
        }

        throw expectedError
    }
}
