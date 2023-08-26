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
    let filters: Filters

    enum CodingKeys: String, CodingKey {
        case currency, eapid, locale
        case siteID = "siteId"
        case destination, checkInDate, checkOutDate, rooms, resultsStartingIndex, resultsSize, sort, filters
    }

    static let dummy: ListBody = .init(currency: "USD", eapid: 1, locale: "en_US", siteID: 300000001, destination: .init(regionID: "6054439"), checkInDate: .init(day: 28, month: 08, year: 2023), checkOutDate: .init(day: 30, month: 08, year: 2023), rooms: [.init(adults: 1, children: [])], resultsStartingIndex: 0, resultsSize: 200, sort: "PRICE_LOW_TO_HIGH", filters: .init(price: .init(max: 10000, min: 2)))
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
