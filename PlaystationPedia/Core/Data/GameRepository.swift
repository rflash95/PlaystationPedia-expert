//
//  GameRepository.swift
//  PlaystationPedia
//
//  Created by rzamau on 18/12/22.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    func getUpcomingGames() -> AnyPublisher<[GameModel], Error>
    func getGamesByGenre(genre:String) -> AnyPublisher<[GameModel], Error>
    func searchGame(keyword: String) -> AnyPublisher<[GameModel], Error>
    func getGameDetail(id: Int) -> AnyPublisher<GameModel, Error>
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func getFavorite(id: Int) -> AnyPublisher<FavoriteModel, Error>
    func getFavorites() -> AnyPublisher<[FavoriteModel], Error>
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

final class GameRepository: NSObject {
    typealias GameInstance = (LocaleDataSource,RemoteDataSource) -> GameRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource,remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.locale.addFavorite(from: game).eraseToAnyPublisher()
    }
    
    func getFavorites() -> AnyPublisher<[FavoriteModel], Error> {
        return self.locale.getFavorites().map {FavoriteMapper.mapFavoriteEntitiesToDomains(input: $0)}.eraseToAnyPublisher()
    }
    
    func getFavorite(id: Int) -> AnyPublisher<FavoriteModel, Error> {
        return self.locale.getFavorite(id: id).map {FavoriteMapper.mapFavoriteEntityToDomain(input: $0)}.eraseToAnyPublisher()
    }
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.locale.deleteFavorite(id: id)
    }

    func getUpcomingGames() -> AnyPublisher<[GameModel], Error> { 
        return self.locale.getUpcomingGames()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.getUpcomingGames()
                        .map { GameMapper.mapGameResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getUpcomingGames()
                          .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.getUpcomingGames()
                        .map {GameMapper.mapGameEntitiesToDomains(input: $0)}.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getGamesByGenre(genre: String) -> AnyPublisher<[GameModel], Error> {
        return self.locale.getUpcomingGames()
            .flatMap { _ -> AnyPublisher<[GameModel], Error> in
                    return self.remote.getGamesByGenre(genre: genre)
                        .map { GameMapper.mapGameResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getGamesByGenre(genre: genre)
                          .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                        }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    func searchGame(keyword: String) -> AnyPublisher<[GameModel], Error> {
        return self.locale.searchGame(keyword: keyword)
            .flatMap { _ -> AnyPublisher<[GameModel], Error> in
                    return self.remote.searchGame(keyword: keyword)
                        .map { GameMapper.mapGameResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.searchGame(keyword: keyword)
                          .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                        }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    func getGameDetail(id: Int) -> AnyPublisher<GameModel, Error> {
        return self.locale.getGameDetail(id: id)
            .flatMap { _ -> AnyPublisher<GameModel, Error> in
                    return self.remote.getGameDetail(gameId: id)
                        .map { GameMapper.mapGameDetailResponseToEntity(input: $0) }
                        .flatMap { self.locale.addGame(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getGameDetail(id: id)
                          .map { GameMapper.mapGameDetailEntityToDomain(input: $0) }
                        }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
