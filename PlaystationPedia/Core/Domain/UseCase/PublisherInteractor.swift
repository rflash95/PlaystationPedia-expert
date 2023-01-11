//
//  PublisherInteractor.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import Combine

protocol PublisherUseCase {
    func getPublishers() -> AnyPublisher<[PublisherModel], Error>
}

class PublisherInteractor: PublisherUseCase {
    private let repository: PublisherRepositoryProtocol
    required init(repository: PublisherRepositoryProtocol) {
        self.repository = repository
    }
    func getPublishers() -> AnyPublisher<[PublisherModel], Error> {
        return repository.getPublishers()
    }
}
