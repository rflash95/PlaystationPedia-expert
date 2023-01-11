//
//  FavoriteMapper.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/01/23.
//

import Foundation

final class FavoriteMapper {
    static func mapFavoriteEntitiesToDomains(
        input favoriteEntities: [FavoriteEntity]
    ) -> [FavoriteModel] {
        return favoriteEntities.map { result in
            return FavoriteModel(id: result.id,
                                 title: result.title,
                                 rating: result.rating,
                                 imageUrl: result.imageUrl,
                                 releaseDate: result.releaseDate)
        }
    }
    
    static func mapFavoriteEntityToDomain(
        input favoriteEntity: FavoriteEntity
    ) -> FavoriteModel {
        return FavoriteModel(id: favoriteEntity.id,
                             title: favoriteEntity.title,
                             rating: favoriteEntity.rating,
                             imageUrl: favoriteEntity.imageUrl,
                             releaseDate: favoriteEntity.releaseDate)
    }
}
