//
//  GaneMapper.swift
//  PlaystationPedia
//
//  Created by rzamau on 18/12/22.
//

final class GameMapper {
    
    static func mapGameResponsesToEntities(
        input gameResponse: [GameResult]
    ) -> [GameEntity] {
        return gameResponse.map { result in
            let newGame = GameEntity()
            newGame.id = result.id
            newGame.title = result.name
            newGame.desc = ""
            newGame.genres = result.genres.map {$0.name}.joined(separator: ",")
            newGame.publisher = ""
            newGame.developer = ""
            newGame.releaseDate = result.released?.formatDate() ?? nil
            newGame.imageUrl = result.backgroundImage ?? ""
            newGame.platforms = ""
            newGame.ageRated = ""
            newGame.rating = result.rating.ridZero()
            return newGame 
        }
    }
    
    static func mapGameResponsesToDomains(
        input gameResponse: [GameResult]
    ) -> [GameModel] {
        return gameResponse.map { result in
            return GameModel(id: result.id,
                             title: result.name,
                             description: "",
                             genres: result.genres.map {$0.name}.joined(separator: ","),
                             publisher: "",
                             developer: "",
                             releaseDate: result.released?.formatDate() ?? nil,
                             imageUrl: result.backgroundImage ?? "",
                             platforms: "",
                             ageRated: "",
                             rating: result.rating.ridZero()
            )
        }
    }
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(id: result.id,
                             title: result.title,
                             description: result.desc,
                             genres: result.genres,
                             publisher: result.publisher,
                             developer: result.developer,
                             releaseDate: result.releaseDate,
                             imageUrl: result.imageUrl,
                             platforms: result.platforms,
                             ageRated: result.ageRated,
                             rating: result.rating)
        }
    }
        
    static func mapGameDetailResponseToEntity(
        input gameResponse: GameDetailResponse
    ) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = gameResponse.id
        newGame.title = gameResponse.name
        newGame.desc = gameResponse.descriptionRaw
        newGame.genres = gameResponse.genres.map {$0.name}.joined(separator: ",")
        newGame.publisher = gameResponse.publishers.map {$0.name}.joined(separator: ",")
        newGame.developer = gameResponse.developers.map {$0.name}.joined(separator: ",")
        newGame.releaseDate = gameResponse.released?.formatDate() ?? nil
        newGame.imageUrl = gameResponse.backgroundImage ?? ""
        newGame.platforms = gameResponse.parentPlatforms.map {$0.platform.name}.joined(separator: ",")
        newGame.ageRated = gameResponse.esrbRating?.name ?? "Not Rated"
        newGame.rating = gameResponse.rating.ridZero()
        return newGame
    }
    static func mapGameDetailEntityToDomain(
        input gameEntity: GameEntity
    ) -> GameModel {
        return GameModel(id: gameEntity.id,
                         title: gameEntity.title,
                         description: gameEntity.desc,
                         genres: gameEntity.genres,
                         publisher: gameEntity.publisher,
                         developer: gameEntity.developer,
                         releaseDate: gameEntity.releaseDate,
                         imageUrl: gameEntity.imageUrl,
                         platforms: gameEntity.platforms,
                         ageRated: gameEntity.ageRated,
                         rating: gameEntity.rating)
    }
    static func mapGameDetailResponseToDomain(
        input gameResponse: GameDetailResponse
    ) -> GameModel {
        return GameModel(id: gameResponse.id,
                         title: gameResponse.name,
                         description: gameResponse.descriptionRaw,
                         genres: gameResponse.genres.map {$0.name}.joined(separator: ","),
                         publisher: gameResponse.publishers.map {$0.name}.joined(separator: ","),
                         developer: gameResponse.developers.map {$0.name}.joined(separator: ","),
                         releaseDate: gameResponse.released?.formatDate() ?? nil,
                         imageUrl: gameResponse.backgroundImage ?? "",
                         platforms: gameResponse.parentPlatforms.map {$0.platform.name}.joined(separator: ","),
                         ageRated: gameResponse.esrbRating?.name ?? "Not Rated",
                         rating: gameResponse.rating.ridZero()
        )
    }
}
