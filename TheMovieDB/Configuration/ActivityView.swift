//
//  ActivityView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import Foundation
import SwiftUI

struct ActivityView: UIViewControllerRepresentable{
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        //No es necesario implementar nada aquí
    }
}
