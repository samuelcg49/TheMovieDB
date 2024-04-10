//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 10/4/24.
//

import Foundation
import UIKit

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=ac05133fedd9f8efa7c9dc3c714a9f75&language=es-ES&page=1"
    
    func getListOfUpcomingMovies(completion: @escaping (Result<[DataMovie], APError>) -> Void)  {
        guard let url = URL(string: NetworkManager.upcoming) else {
            completion(.failure(.invalidURL))
            
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error{
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completion(.failure(.invalidData))
                return
                
            }
            
            do{
                let decodedResponse = try JSONDecoder().decode(MovieDataModel.self, from: data)
                completion(.success(decodedResponse.results))
            }catch{
                print("Debug: error \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

struct Constants {
    static let urlImages = "https://image.tmdb.org/t/p/original"
    static let placeholder = "https://cringemdb.com/img/movie-poster-placeholder.png"
    static let urlTrailer = "uxRm9UiJ0PY&t=12s"
}
