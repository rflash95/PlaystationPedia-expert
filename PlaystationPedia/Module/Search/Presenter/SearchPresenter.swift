//
//  SearchPresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import SwiftUI
import Combine

class SearchPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var searchUseCase: SearchGameUseCase
    private let router = SearchRouter()
    
    @Published var searchText = ""
    @Published var games = [GameModel]()
    @Published var isFound = true
    @Published var loadingState: Bool = false
    @Published var errorMessage: String = ""
    
    func searchGames() {
        loadingState = true
        searchUseCase.searchGame(keyword: searchText)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                 self.games = games
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
