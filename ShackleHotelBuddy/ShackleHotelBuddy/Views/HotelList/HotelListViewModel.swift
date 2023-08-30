//
//  HotelListViewModel.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

class HotelListViewModel: ObservableObject {
    @Published var hotels: [Property] = [.init(typename: nil, id: "1", name: "Test", propertyImage: .init(typename: nil, image: .init(typename: nil, description: "Nice", url: "https://images.trvl-media.com/lodging/10000000/9500000/9493000/9492953/6765e39b.jpg?impolicy=resizecrop&rw=455&ra=fit")), price: nil, neighborhood: nil, reviews: nil)]

    @Published var filter: Filter = .init(priceRange: nil, rating: nil)
    
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
