//
//  MoviesViewModel.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 10/4/24.
//

import Foundation

class MoviesViewModel: ObservableObject{
    @Published var upcomingMovies: [DataMovie] = []
    @Published var nowPlayingMovies: [DataMovie] = []
    @Published var trendingMovies: [DataMovie] = []
    
    init(){
        getListOfUpcomingMovies()
        getMoviesNowPlaying()
        getTrendingMovies()
    }
    
    func getListOfUpcomingMovies(){
        NetworkManager.shared.getListOfUpcomingMovies{ [weak self] result in
            DispatchQueue.main.async{
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.upcomingMovies = movies
                    
                case .failure(let error):
                    switch error{
                        
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
            
        }
    }
    
    func getMoviesNowPlaying(){
        NetworkManager.shared.getMoviesNowPlaying{ [weak self] result in
            DispatchQueue.main.async{
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.nowPlayingMovies = movies
                    
                case .failure(let error):
                    switch error{
                        
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getTrendingMovies(){
        NetworkManager.shared.getMoviesTrending{ [weak self] result in
            DispatchQueue.main.async{
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.trendingMovies = movies
                    
                case .failure(let error):
                    switch error{
                        
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
}
