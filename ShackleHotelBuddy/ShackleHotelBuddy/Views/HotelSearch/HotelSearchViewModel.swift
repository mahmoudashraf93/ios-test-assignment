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
    
    init() {
        checkInDateViewModel = DateSelectionViewModel(icon: "icons/event_upcoming",
                                                      title: "Check In")
        
        checkOutDateViewModel = DateSelectionViewModel(icon: "icons/event_available",
                                                       title: "Check Out")
    }
}
