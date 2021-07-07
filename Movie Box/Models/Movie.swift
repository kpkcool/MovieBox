//
//  MovieData.swift
//  Movie Box
//
//  Created by K Praveen Kumar on 07/07/21.
//

import Foundation

struct Movie : Decodable, Identifiable {
    var id: Int?
    var backdrop_path: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var popularity: Double?
    var title: String?
    var vote_average: Double?
}


