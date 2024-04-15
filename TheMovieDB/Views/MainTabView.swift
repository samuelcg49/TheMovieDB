//
//  MainTabView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            MoviesView()
                .tabItem { Image(systemName: "play.rectangle") }
            
            SearchMoviesView()
                .tabItem { Image(systemName: "magnifyingglass") }
            
            FeedbackView()
                .tabItem { Image(systemName: "gearshape") }
        }
    }
}

#Preview {
    MainTabView()
}
