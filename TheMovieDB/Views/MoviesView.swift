//
//  MoviesView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 10/4/24.
//

import SwiftUI
import Kingfisher

struct MoviesView: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    var gridITemLayout = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Text("Próximos estrenos")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    ScrollView(.horizontal){
                        LazyHGrid(rows: gridITemLayout, spacing: 20){
                            ForEach(viewModel.upcomingMovies, id: \.id){ movie in
                                NavigationLink{
                                    MovieDetailView(movie: movie)
                                }label:{
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder{progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 150, height: 200.05)
                                        .task{
                                            if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                                                await viewModel.fetchNextSetOfMovies()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    Text("Ahora en cartelera")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    ScrollView(.horizontal){
                        LazyHGrid(rows: gridITemLayout, spacing: 20){
                            ForEach(viewModel.nowPlayingMovies, id: \.id){ movie in
                                NavigationLink{
                                    MovieDetailView(movie: movie)
                                }label:{
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder{progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 190, height: 255)
                                }
                            }
                        }
                    }
                    
                    Text("Tendencia")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    ScrollView(.horizontal){
                        LazyHGrid(rows: gridITemLayout, spacing: 20){
                            ForEach(viewModel.trendingMovies, id: \.id){ movie in
                                NavigationLink{
                                    MovieDetailView(movie: movie)
                                }label:{
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder{ progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 255, height: 340)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}
