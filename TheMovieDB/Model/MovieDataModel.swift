//
//  MovieDataModel.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 10/4/24.
//

import Foundation

struct MovieDataModel: Codable{
    let results: [DataMovie]
    let total_pages: Int
    
}

struct DataMovie: Codable{
    let backdrop_path: String?
    let id: Int?
    let original_title: String?
    let overview: String?
    let original_language: String?
    let title: String?
    let release_date: String?
    let poster_path: String?
}

struct MockData{
    static let movie = DataMovie(backdrop_path: "/j3Z3XktmWB1VhsS8iXNcrR86PXi.jpg", id: 823464, original_title: "Godzilla x Kong: The New Empire", overview: "Una aventura cinematográfica completamente nueva, que enfrentará al todopoderoso Kong y al temible Godzilla contra una colosal amenaza desconocida escondida dentro de nuestro mundo. La nueva y épica película profundizará en las historias de estos titanes, sus orígenes y los misterios de Isla Calavera y más allá, mientras descubre la batalla mítica que ayudó a forjar a estos seres extraordinarios y los unió a la humanidad para siempre.", original_language: "en", title: "Godzilla y Kong: El nuevo imperio", release_date: "2024-03-27", poster_path: "/2YqZ6IyFk7menirwziJvfoVvSOh.jpg")
    static let idTrailer = "uI5rezDfDqI"
}
