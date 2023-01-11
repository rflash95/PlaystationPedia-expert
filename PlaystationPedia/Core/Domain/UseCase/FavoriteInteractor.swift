//
//  FavoriteInteractor.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/01/23.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavorites() -> AnyPublisher<[FavoriteModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GameRepositoryProtocol
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites() -> AnyPublisher<[FavoriteModel], Error> {
        return repository.getFavorites()
    }
}
