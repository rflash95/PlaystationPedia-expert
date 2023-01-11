//
//  GameModel.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/10/22.
//

import Foundation

struct GameModel {
let id: Int
let title: String
let description: String
let genres: String
let publisher: String
let developer: String
let releaseDate: Date?
let imageUrl: String
let platforms: String
let ageRated: String
let rating: String
}

let dummygameData = [
    GameModel(id: 391397,
        title: "Grounded",
         description: "The world is a vast, beautiful, and dangerous place – especially when you have been shrunken",
         genres: "Adventure, Indie",
         publisher: "Xbox Game Studios",
         developer: "Team Dev",
         releaseDate: "2030-01-01".formatDate(),
         imageUrl: "https://media.rawg.io/media/resize/1920/-/screenshots/c7c/c7c23cc42e56fb2598fe730a0609a967.jpg",
         platforms: "PS 5,Xbox Series S/X, PC, Xbox One",
         ageRated: "13+ Teen",
         rating: 4.5.ridZero()),
    GameModel(id: 391397,
         title: "Grounded 2",
         description: "The world is a vast, beautiful, and dangerous place – especially when you have been shrunken",
         genres: "Adventure, Indie",
         publisher: "Xbox Game Studios",
         developer: "Team Dev",
         releaseDate: "2030-01-01".formatDate(),
         imageUrl: "https://media.rawg.io/media/resize/1920/-/screenshots/c7c/c7c23cc42e56fb2598fe730a0609a967.jpg",
         platforms: "PS 5,Xbox Series S/X, PC, Xbox One",
         ageRated: "13+ Teen",
         rating: 5.0.ridZero())
]
