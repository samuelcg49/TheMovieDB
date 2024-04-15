//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 10/4/24.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
