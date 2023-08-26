//
//  PropertiesEndpoint.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

enum PropertiesEndpoint: Endpoint {
    var body: Encodable? {
        return ListBody.dummy
    }

    var method: HTTPMethod {
        return .post
    }

    case list

    var baseURL: String {
        Constants.API.baseURL
    }

    var path: String {
        switch self {
        case .list:
            return "properties/v2/list"
        }
    }

    var headers: [String : String] {
        return ["X-RapidAPI-Key": Constants.API.APIKey,
                "X-RapidAPI-Host": "hotels4.p.rapidapi.com"]
    }
}
