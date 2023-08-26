//
//  Endpoint.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String {get}
    var body: Encodable? { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }

    func getURL() -> URL?
}

extension Endpoint {
    func getURL() -> URL? {
        URL(string: baseURL)?.appendingPathComponent(path)
    }
}
