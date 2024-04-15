//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 12/4/24.
//

import SwiftUI
import Kingfisher
import YouTubeiOSPlayerHelper

struct MovieDetailView: View {
    @StateObject var viewModel = TrailerViewModel()
    @State private var isLoading = false
    @State private var urlSelected = ""
    @State private var showTrailer = false
    
    let movie: DataMovie
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                //TrailerView
                    if !viewModel.listOfTrailers.isEmpty{
                        YTWrapper(videoID: "\(viewModel.listOfTrailers[0].key)")
                            .frame(height: 200)
                            .cornerRadius(12)
                            .padding(.horizontal, 15)
                    }
                //Title
                Text(movie.title ?? movie.original_title ?? "")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.horizontal, 25)
                
                //Desciption
                Text(movie.overview ?? "")
                    .font(.body)
                    .padding(.horizontal, 25)
                
                HStack{
                    Text("Estreno \(movie.release_date ?? "")")
                        .font(.title3)
                    
                    Button(action: {
                        //Agregar favorios
                    }, label: {
                        Image(systemName: "heart")
                    })
                }
                
                //Trailers
                ScrollView{
                    ForEach(viewModel.listOfTrailers, id: \.key){ trailer in
                        TrailerCellView(urlMovie: movie.backdrop_path ?? "", trailer: trailer)
                            .onTapGesture {
                                self.urlSelected = trailer.key
                                showTrailer = true
                            }
                    }
                }
                .frame(height: 300)
                
                //Imagen
                RemoteImageMovieView(url: movie.backdrop_path ?? "")
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .shadow(radius: 12)
                    .cornerRadius(12)
                    .padding(.horizontal, 15)
                
                    .navigationBarItems(trailing: Button(action: {
                        //Compartir
                    }, label: {
                        Image(systemName: "square.and.row.up.fill")
                    }))
            }.sheet(isPresented: $showTrailer, content: {
                EmptyView()
            })
        }.onAppear(perform: {
            viewModel.getTrailers(id: movie.id ?? 20)
        })
    }
}


#Preview {
    MovieDetailView(movie: MockData.movie)
}

struct YTWrapper: UIViewRepresentable{
    var videoID: String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context){
        
    }
}

