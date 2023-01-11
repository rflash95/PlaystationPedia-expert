//
//  HomeInteractor.swift
//  PlaystationPedia
//
//  Created by rzamau on 04/01/23.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getUpcomingGames() -> AnyPublisher<[GameModel], Error>
    func getGamesByGenre(genre: String) -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    func getUpcomingGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getUpcomingGames()
    }
   func getGamesByGenre(genre: String) -> AnyPublisher<[GameModel], Error> {
        return repository.getGamesByGenre(genre: genre)
    }
}
