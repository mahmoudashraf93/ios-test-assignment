//
//  NumberSelectionViewModel.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import Foundation

class NumberSelectionViewModel: ObservableObject {
    var icon: String
    var title: String
    @Published var number: Int

    init(icon: String,
         title: String,
         number: Int) {
        self.icon = icon
        self.title = title
        self.number = number
    }
}
