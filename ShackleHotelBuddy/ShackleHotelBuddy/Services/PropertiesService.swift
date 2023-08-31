//
//  PropertiesService.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation
import Combine

protocol PropertiesServiceProtocol {
    func fetchProperties(with parameters: ListParameters) async throws -> PropertiesResponse
    func propertyDetail(for propertyID: String) async throws -> Property
}

class PropertiesService: PropertiesServiceProtocol {
    private var networkClient: Requestable

    init(networkRequest: Requestable = NetworkClient()) {
        self.networkClient = networkRequest
    }

    func fetchProperties(with parameters: ListParameters) async throws -> PropertiesResponse {
        let endpoint = PropertiesEndpoint.list(params: parameters)
        return try await networkClient.sendRequest(endpoint)
    }

    func propertyDetail(for propertyID: String) async throws -> Property {
        let endpoint = PropertiesEndpoint.details(propertyID: propertyID)
        return try await networkClient.sendRequest(endpoint)
    }
}
