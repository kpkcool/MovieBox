//
//  Response.swift
//  Movie Box
//
//  Created by K Praveen Kumar on 07/07/21.
//

import Foundation

struct ErrorResponse: Decodable {
    var status_message: String?
    var status_code: Int?
}

struct DiscoverResponse: Decodable {
    var page: Int?
    var results: [Movie]?
    var totalResults: Int?
    var totalPages: Int?
}
