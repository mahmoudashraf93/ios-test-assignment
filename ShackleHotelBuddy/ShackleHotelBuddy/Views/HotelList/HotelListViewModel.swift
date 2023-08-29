//
//  HotelListViewModel.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

class HotelListViewModel: ObservableObject {
   @Published var hotels: [Property] = []

    private let service: PropertiesServiceProtocol

    init(service: PropertiesServiceProtocol = PropertiesService()) {
        self.service = service
    }


    @MainActor
    func fetchHotels() async {
        do {
            let response = try await service.fetchProperties()
            hotels = response.data.propertySearch.properties
        } catch  {
            // TODO:- Handle error properly
        }
    }
}
