//
//  PublisherModel.swift
//  PlaystationPedia
//
//  Created by rzamau on 06/11/22.
//

import Foundation

struct PublisherModel {
    let id: Int
    let name: String
    let gamesCount: Int
    let imageUrl: String
    let description: String
}
let dummyPublishers = [
PublisherModel(id: 354,
              name: "Electronic Arts",
              gamesCount: 1307,
              imageUrl: "https://media.rawg.io/media/games/e44/e445335e611b4ccf03af71fffcbd30a4.jpg",
              description: "<p>Electronic Arts is a Japanese video game publisher.</p>"),
PublisherModel(
    id: 354,
    name: "Electronic Arts",
    gamesCount: 1307,
    imageUrl: "https://media.rawg.io/media/games/e44/e445335e611b4ccf03af71fffcbd30a4.jpg",
    description: "<p>Electronic Arts is a Japanese video game publisher.</p>")
]
