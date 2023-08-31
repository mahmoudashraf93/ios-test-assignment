//
//  HotelSearchViewModel.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

class HotelSearchViewModel: ObservableObject {
    @Published var checkInDateViewModel: DateSelectionViewModel
    @Published var checkOutDateViewModel: DateSelectionViewModel
    @Published var adultsCountViewModel: NumberSelectionViewModel
    @Published var childrenCountViewModel: NumberSelectionViewModel

    init() {
        checkInDateViewModel = DateSelectionViewModel(icon: "icons/event_upcoming",
                                                      title: "Check In")
        
        checkOutDateViewModel = DateSelectionViewModel(icon: "icons/event_available",
                                                       title: "Check Out")

        adultsCountViewModel = NumberSelectionViewModel(icon: "icons/person",
                                                        title: "Adults",
                                                        number: 1)

        childrenCountViewModel = NumberSelectionViewModel(icon: "icons/supervisor_account",
                                                          title: "Children",
                                                          number: 0)
    }

    var hotelListViewModel: HotelListViewModel {
        .init(listParameters: .init(checkInDate: checkInDateViewModel.date,
                                    checkOutDate: checkOutDateViewModel.date,
                                    adults: adultsCountViewModel.number,
                                    children: childrenCountViewModel.number,
                                    priceRange: nil,
                                    minRating: nil))
    }
}
