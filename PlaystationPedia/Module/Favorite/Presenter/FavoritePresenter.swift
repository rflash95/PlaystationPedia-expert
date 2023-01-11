//
//  FavoritePresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/01/23.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var favoriteUseCase: FavoriteUseCase
    private let router = FavoriteRouter()

    @Published var favorites = [FavoriteModel]()
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    func refresh() {
        getFavorites()
    }
    
    func getFavorites() {
        loadingState = true
        favoriteUseCase.getFavorites()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { favorites in
                self.favorites = favorites
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for gameId: Int,
        @ViewBuilder content: () -> Content
      ) -> some View {
        NavigationLink(
        destination: router.makeDetailView(for: gameId)) { content() }
      }
}
