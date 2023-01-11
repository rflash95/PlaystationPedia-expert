//
//  DetailPublisher.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import Combine

protocol DetailPublisherUseCase {

    func getPublisher(id: Int) -> AnyPublisher<PublisherModel, Error>

}

class DetailPublisherInteractor: DetailPublisherUseCase {
  private let repository: PublisherRepositoryProtocol

  required init(
    repository: PublisherRepositoryProtocol
  ) {
    self.repository = repository
  }
    func getPublisher(id: Int) -> AnyPublisher<PublisherModel, Error> {
        return repository.getPublisherDetail(id: id)
    }
}
