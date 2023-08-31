//
//  PropertiesEndpoint.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

struct ListParameters {
    let checkInDate: Date
    let checkOutDate: Date
    let adults: Int
    let children: Int
    var priceRange: ClosedRange<Int>?
    let minRating: Int?
}

enum PropertiesEndpoint: Endpoint {

    case list(params: ListParameters)
    case details(propertyID: String)

    var baseURL: String {
        Constants.API.baseURL
    }

    var body: Encodable? {
        switch self {
        case .list(let params):
            return ListBody.create(from: params)
        case .details(let propertyID):
            return nil // TODO:- Create object
        }
    }

    var method: HTTPMethod {
        return .post
    }


    var path: String {
        switch self {
        case .list:
            return "properties/v2/list"
        case .details:
            return "properties/v2/detail"
        }
    }

    var headers: [String : String] {
        return ["X-RapidAPI-Key": Constants.API.APIKey,
                "X-RapidAPI-Host": "hotels4.p.rapidapi.com"]
    }
}
