//
//  RemoteImageMovieView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import SwiftUI
import Kingfisher

struct RemoteImageMovieView: View {
    var url: String
    var body: some View {
        KFImage(URL(string: "\(Constants.urlImages)\(url)"))
            .resizable()
            .placeholder{ progress in
                    ProgressView()
            }
    }
}


