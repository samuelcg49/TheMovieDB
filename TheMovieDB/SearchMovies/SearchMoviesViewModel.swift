//
//  SearchMoviesViewModel.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import Foundation

class SearchMoviesViewModel: ObservableObject{
    @Published var moviesFounded: [DataMovie] = []
    
    func searchMovie(name: String){
        NetworkManager.shared.searchMovies(name: name){ [weak self] result in
            DispatchQueue.main.async{
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    self.moviesFounded = movies
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
}
