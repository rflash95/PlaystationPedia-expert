//
//  SearchUseCase.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import Combine

protocol SearchGameUseCase {

    func searchGame(keyword: String) -> AnyPublisher<[GameModel], Error>

}

class SearchGameInteractor: SearchGameUseCase {    
  private let repository: GameRepositoryProtocol

  required init(
    repository: GameRepositoryProtocol
  ) {
    self.repository = repository
  }
    func searchGame(keyword: String) -> AnyPublisher<[GameModel], Error> {
        return repository.searchGame(keyword: keyword)
    }
}
