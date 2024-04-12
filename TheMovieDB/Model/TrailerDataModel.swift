//
//  TrailerDataModel.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 12/4/24.
//

import Foundation

struct TrailerResponse:Codable {
    let id: Int
    let results: [Trailer]
}

struct Trailer:Codable{
    let key: String
    let name: String
    let type: String
    let published_at: String
}
