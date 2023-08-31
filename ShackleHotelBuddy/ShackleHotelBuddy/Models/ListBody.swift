//
//  ListBody.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

// MARK: - ListBody
struct ListBody: Encodable {
    let currency: String
    let eapid: Int
    let locale: String
    let siteID: Int
    let destination: Destination
    let checkInDate, checkOutDate: CheckDate
    let rooms: [Room]
    let resultsStartingIndex, resultsSize: Int
    let sort: String
    let filters: Filters?

    enum CodingKeys: String, CodingKey {
        case currency, eapid, locale
        case siteID = "siteId"
        case destination, checkInDate, checkOutDate, rooms, resultsStartingIndex, resultsSize, sort, filters
    }

    static func create(from parameters: ListParameters) -> ListBody {
        var filtersParam: Filters?
        if let priceRange = parameters.priceRange {
            filtersParam = .init(price: .init(max: priceRange.upperBound, min: priceRange.lowerBound))
        }
        let calendar = Calendar.current
        let checkInDateComponents = calendar.dateComponents([.day, .month, .year],
                                                            from: parameters.checkInDate)

        let checkOutDateComponents = calendar.dateComponents([.day, .month, .year],
                                                             from: parameters.checkOutDate)

        guard let checkInDay = checkInDateComponents.day,
              let checkInMonth = checkInDateComponents.month,
              let checkInYear = checkInDateComponents.year else {
            fatalError("Invalid check in date components")
        }

        guard let checkOutDay = checkOutDateComponents.day,
              let checkOutMonth = checkOutDateComponents.month,
              let checkOutYear = checkOutDateComponents.year else {
            fatalError("Invalid check out date components")
        }


        return .init(currency: "USD",
                     eapid: 1,
                     locale: "en_US",
                     siteID: 300000001,
                     destination: .init(regionID: "6054439"),
                     checkInDate: .init(day: checkInDay,
                                        month: checkInMonth,
                                        year: checkInYear),
                     checkOutDate: .init(day: checkOutDay,
                                        month: checkOutMonth,
                                        year: checkOutYear),
                     rooms: [.init(adults: parameters.adults,
                                   children: [Child](repeating: .init(age: 3),
                                                     count: parameters.children))],
                     resultsStartingIndex: 0,
                     resultsSize: 200,
                     sort: "PRICE_LOW_TO_HIGH",
                     filters: filtersParam)
    }
}

// MARK: - CheckDate
struct CheckDate: Encodable {
    let day, month, year: Int
}

// MARK: - Destination
struct Destination: Encodable {
    let regionID: String

    enum CodingKeys: String, CodingKey {
        case regionID = "regionId"
    }
}

// MARK: - Filters
struct Filters: Encodable {
    let price: Price
}

// MARK: - Price
struct Price: Encodable {
    let max, min: Int
}

// MARK: - Room
struct Room: Encodable {
    let adults: Int
    let children: [Child]
}

// MARK: - Child
struct Child: Encodable {
    let age: Int
}
