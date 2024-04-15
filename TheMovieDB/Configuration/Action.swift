//
//  Action.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import Foundation

struct Action: Identifiable{
    let id = UUID()
    let name: String
    let action: String
    let icon: String
    let url: String
}

var informationActions: [Action] = [
Action(name: "Hacer una sugerencia", action: "sugerencia", icon: "slider.vertical.3", url: "https://google.es"),
Action(name: "Califica la aplicación", action: "califica", icon: "star.leadinghalf.filled", url: "https://apps.apple.com/es/app/instagram/id389801252"),
Action(name: "LinkedIn", action: "seguir", icon: "apps.iphone", url: "https://www.linkedin.com/in/samuelciesgracia/"),
Action(name: "Desarrollador", action: "developer", icon: "person", url: "https://github.com/samuelcg49/"),
Action(name: "Youtube", action: "developer", icon: "apps.iphone", url: "https://youtube.com")
]

var cines: [Action] = [
    Action(name: "Yelmo Cines", action: "", icon: "ticket", url: "https://yelmocines.es/"),
    Action(name: "CineZona", action: "", icon: "ticket", url: "https://cczonaeste.com/")
]
