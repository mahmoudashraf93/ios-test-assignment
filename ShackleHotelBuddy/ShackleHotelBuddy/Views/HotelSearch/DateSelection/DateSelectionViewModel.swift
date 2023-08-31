//
//  DateSelectionViewModel.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import Foundation

class DateSelectionViewModel: ObservableObject {
    var icon: String
    var title: String
    @Published var dateString: String = "DD / MM / YYYY"
    @Published var date: Date = Date()

    init(icon: String,
         title: String) {
        self.icon = icon
        self.title = title
    }

    func updateDate(_ date: Date) {
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        dateString = dateFormatter.string(from: date)
    }
}
