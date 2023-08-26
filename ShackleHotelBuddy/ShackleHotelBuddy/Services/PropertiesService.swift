//
//  PropertiesService.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation
import Combine

protocol PropertiesServiceProtocol {
    func fetchProperties() async throws -> PropertiesResponse
}

class PropertiesService: PropertiesServiceProtocol {
    private var networkClient: Requestable

    init(networkRequest: Requestable = NetworkClient()) {
        self.networkClient = networkRequest
    }

    func fetchProperties() async throws -> PropertiesResponse {
        let endpoint = PropertiesEndpoint.list
        return try await networkClient.sendRequest(endpoint)
    }
}
