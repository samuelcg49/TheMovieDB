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
    @Published private(set) var viewState: ViewState?
    
    var isLoading: Bool{
        viewState == .loading
    }
    
    var isFetching: Bool{
        viewState == .fetching
    }
    
    private var page = 1
    private var totalPages: Int?
    
    init(){
        getListOfUpcomingMovies()
        getMoviesNowPlaying()
        getTrendingMovies()
    }
    
    func getListOfUpcomingMovies(){
        
        viewState = .loading
        defer{ viewState = .finished }
        
        NetworkManager.shared.getListOfUpcomingMovies(numPage: page){ [weak self] result in
            DispatchQueue.main.async{
                guard let self else { return }
                switch result {
                case .success(let result):
                    self.totalPages = result.total_pages
                    self.upcomingMovies = result.results
                    
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
    //Se ejecuta en el hilo principal
    @MainActor
    func fetchNextSetOfMovies() async {
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer{ viewState = .finished }
        
        page += 1
        
        NetworkManager.shared.getListOfUpcomingMovies(numPage: page){ [weak self] result in
            DispatchQueue.main.async{
                guard let self else { return }
                
                switch result {
                case .success(let result):
                    self.upcomingMovies.append(contentsOf: result.results)
                    
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
    
    func hasReachedEnd(of movie: DataMovie) -> Bool{
        upcomingMovies.last?.id == movie.id
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

extension MoviesViewModel{
    enum ViewState{
        case fetching
        case loading
        case finished
    }
}
