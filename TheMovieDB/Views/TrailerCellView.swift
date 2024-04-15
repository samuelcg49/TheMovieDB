//
//  TrailerCellView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import SwiftUI
import Kingfisher

struct TrailerCellView: View {
    let urlMovie: String
    let trailer: Trailer?
    
    var body: some View {
        HStack(spacing: 10.0){
            KFImage(URL(string: "\(Constants.urlImages)\(urlMovie)"))
                .resizable()
                .placeholder({ progress in
                    ProgressView()
                })
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .cornerRadius(12)
                .shadow(radius: 12)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 3.0) {
                Text(trailer?.name ?? "")
                    .lineLimit(2)
                    .font(.body)
                    .foregroundColor(.accentColor)
                
                Text(trailer?.published_at.prefix(10) ?? "")
                    .font(.footnote)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}


#Preview {
    TrailerCellView(urlMovie: "", trailer: nil)
}
