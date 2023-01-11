//
//  PublisherPresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import SwiftUI
import Combine

class PublisherPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var publisher: PublisherUseCase
    private let router = PublisherRouter()
    @Published var publishers = [PublisherModel]()
    @Published var loadingState: Bool = false
    @Published var errorMessage: String = ""
    
    func getPublishers() {
        loadingState = true
        publisher.getPublishers()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { publisher in
                 self.publishers = publisher
            })
            .store(in: &cancellables)
    }

    func linkBuilder<Content: View>(
        for publisherId: Int,
        @ViewBuilder content: () -> Content
      ) -> some View {
        NavigationLink(
        destination: router.makeDetailView(for: publisherId)) { content() }
      }
}
