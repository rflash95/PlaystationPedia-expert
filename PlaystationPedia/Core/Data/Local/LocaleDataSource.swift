//
//  RealmManager.swift
//  PlaystationPedia
//
//  Created by rzamau on 05/11/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
    func getUpcomingGames() -> AnyPublisher<[GameEntity], Error>
    func getGamesByGenre(genre: String) -> AnyPublisher<[GameEntity], Error>
    func searchGame(keyword: String) -> AnyPublisher<[GameEntity],  Error>
    func getGameDetail(id: Int) -> AnyPublisher<GameEntity, Error>
    func deleteGame(id: Int) -> AnyPublisher<Bool, Error>
    func addPublishers(from publishers: [PublisherEntity]) -> AnyPublisher<Bool, Error>
    func getPublishers() -> AnyPublisher<[PublisherEntity], Error>
    func getPublisher(id: Int) -> AnyPublisher<PublisherEntity, Error>
    func deletePublisher(id: Int) -> AnyPublisher<Bool, Error>
    func addFavorite(from game: GameModel) -> AnyPublisher<Bool, Error>
    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error>
    func getFavorite(id: Int) -> AnyPublisher<FavoriteEntity, Error>
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func addPublishers(from publishers: [PublisherEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for publisher in publishers {
                            realm.add(publisher, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addPublisher(from publisher: PublisherEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(publisher, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getPublishers() -> AnyPublisher<[PublisherEntity], Error> {
        return Future<[PublisherEntity], Error> { completion in
            if let realm = self.realm {
                let publishers: Results<PublisherEntity> = {
                    realm.objects(PublisherEntity.self)
                }()
                completion(.success(publishers.toArray(ofType: PublisherEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getPublisher(id: Int) -> AnyPublisher<PublisherEntity, Error> {
        return Future<PublisherEntity, Error> { completion in
            if let realm = self.realm {
                let publishers: Results<PublisherEntity> = {
                    realm.objects(PublisherEntity.self)
                }()
                let publisher = publishers.filter("id == \(id)")
                if let first = publisher.first {
                    completion(.success(first))
                } else {
                    completion(.failure(AppError.custom(message: "The publisher data not found")))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deletePublisher(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let publishers: Results<PublisherEntity> = {
                        realm.objects(PublisherEntity.self)
                    }()
                    let publisher = publishers.filter("id == \(id)")
                    try realm.write {
                        realm.delete(publisher)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getUpcomingGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "releaseDate", ascending: false)
                }()
                let prefix = games.prefix(10)
                let newGames = Array(prefix.map { $0 })
                completion(.success(newGames))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGamesByGenre(genre: String) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .filter("genres CONTAINS[cd] %@", genre)
                }()
                
                let prefix = games.prefix(10)
                let newGames = Array(prefix.map { $0 })
                completion(.success(newGames))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func searchGame(keyword: String) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .filter("title CONTAINS[cd] %@", keyword)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                let game = games.filter("id == \(id)")
                if let first = game.first {
                    completion(.success(first))
                } else {
                    completion(.failure(AppError.custom(message: "The game data not found")))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteGame(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let games: Results<GameEntity> = {
                        realm.objects(GameEntity.self)
                    }()
                    let game = games.filter("id == \(id)")
                    try realm.write {
                        realm.delete(game)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(from game: GameModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        let newFavorite = FavoriteEntity()
                        newFavorite.id = game.id
                        newFavorite.title = game.title
                        newFavorite.rating = game.rating
                        newFavorite.imageUrl = game.imageUrl
                        newFavorite.releaseDate = game.releaseDate ?? Date()
                        realm.add(newFavorite, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
        return Future<[FavoriteEntity], Error> { completion in
            if let realm = self.realm {
                let favorites: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                }()
                completion(.success(favorites.toArray(ofType: FavoriteEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavorite(id: Int) -> AnyPublisher<FavoriteEntity, Error> {
        return Future<FavoriteEntity, Error> { completion in
            if let realm = self.realm {
                let favorites: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                }()
                let favorite = favorites.filter("id == \(id)")
                if let first = favorite.first {
                    completion(.success(first))
                } else {
                    completion(.failure(AppError.custom(message: "The favorite data not found")))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let favorites: Results<FavoriteEntity> = {
                        realm.objects(FavoriteEntity.self)
                    }()
                    let favorite = favorites.filter("id == \(id)")
                    try realm.write {
                        realm.delete(favorite)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
