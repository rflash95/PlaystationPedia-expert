//
//  DetailPublisherPresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import SwiftUI
import Combine

class DetailPublisherPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var detailPublisherUseCase: DetailPublisherUseCase
    private var publisherId: Int

    @Published var publisher: PublisherModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(publisherId: Int) {
        self.publisherId = publisherId
        self.getPublisher()
    }

    func getPublisher() {
        loadingState = true
        detailPublisherUseCase.getPublisher(id: publisherId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { publisher in
                self.publisher = publisher
            })
            .store(in: &cancellables)
    }
}
