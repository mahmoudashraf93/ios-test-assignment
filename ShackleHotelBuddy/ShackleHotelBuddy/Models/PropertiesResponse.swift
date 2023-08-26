//
//  PropertiesResponse.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

// MARK: - PropertiesResponse
struct PropertiesResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let propertySearch: PropertySearch
}

// MARK: - PropertySearch
struct PropertySearch: Codable {
    let typename: String?
    let properties, propertySearchListings: [Property]

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case properties, propertySearchListings
    }
}


// MARK: - Property
struct Property: Codable, Identifiable {
    let typename: String?
    let id: String?
    let name: String?
    let propertyImage: PropertyImage?
    let price: PropertyPrice?
    let neighborhood: PropertyNeighborhood?
    let reviews: Reviews?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, name, propertyImage, price, reviews, neighborhood

    }
}
// MARK: - PropertyNeighborhood
struct PropertyNeighborhood: Codable {
    let typename: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case name
    }
}
// MARK: - PropertyPrice
struct PropertyPrice: Codable {
    let typename: String?
    let options: [PriceOption]
    let lead: Lead
    let priceMessages: [PriceMessage]

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case options, lead, priceMessages
    }
}

// MARK: - Lead
struct Lead: Codable {
    let formatted: String
}

// MARK: - PriceOption
struct PriceOption: Codable {
    let typename: String?
    let strikeOut: Lead?
    let disclaimer: PriceMessage?
    let formattedDisplayPrice: String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case strikeOut, disclaimer, formattedDisplayPrice
    }
}

// MARK: - PriceMessage
struct PriceMessage: Codable {
    let typename: String?
    let value: String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case value
    }
}

// MARK: - PropertyImage
struct PropertyImage: Codable {
    let typename: String?
    let image: ImageResponse
}

// MARK: - Image
struct ImageResponse: Codable {
    let typename: String?
    let description: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case description, url
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let typename: String?
    let score: Double
    let total: Int

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case score, total
    }
}
