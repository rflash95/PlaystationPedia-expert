//
//  DetailGameUseCase.swift
//  PlaystationPedia
//
//  Created by rzamau on 07/01/23.
//

import Foundation
import Combine

protocol DetailGameUseCase {
    func getGame(id: Int) -> AnyPublisher<GameModel, Error>
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func getFavorite(id: Int) -> AnyPublisher<FavoriteModel, Error>
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

class DetailGameInteractor: DetailGameUseCase {

    private let repository: GameRepositoryProtocol
    required init(
        repository: GameRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func getGame(id: Int) -> AnyPublisher<GameModel, Error> {
        return repository.getGameDetail(id: id)
    }
    
    func addFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(game: game)
    }
    
    func getFavorite(id: Int) -> AnyPublisher<FavoriteModel, Error> {
        return repository.getFavorite(id: id)
    }
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavorite(id: id)
    }
}
