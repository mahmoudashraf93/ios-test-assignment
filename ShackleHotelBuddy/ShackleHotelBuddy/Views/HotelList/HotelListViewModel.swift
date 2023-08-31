//
//  HotelListViewModel.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

class HotelListViewModel: ObservableObject {
    @Published var hotels: [Property] = [Property.mock]
    @Published var filter: Filter = .init(priceRange: nil, rating: nil)

    let listParameters: ListParameters

    private let service: PropertiesServiceProtocol

    init(service: PropertiesServiceProtocol = PropertiesService(),
         listParameters: ListParameters) {
        self.service = service
        self.listParameters = listParameters
    }


    @MainActor
    func fetchHotels() async {
//        var params = listParameters
//        params.priceRange = filter.priceRange
//        hotels.removeAll()
//        do {
//            let response = try await service.fetchProperties(with: params)
//            hotels = response.data.propertySearch.properties
//        } catch  {
//            // TODO:- Handle error properly
//        }
    }
}
