//
//  HomePresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 07/01/23.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var homeUseCase: HomeUseCase
    private let router = HomeRouter()

    @Published var upcomingGames = [GameModel]()
    @Published var gameByGenre = [GameModel]()
    @Published var genreSelected = "action"
    @Published var errorMessage: String = ""
    @Published var loadingUpcomingGamesState: Bool = false
    @Published var loadingGamesByGenreState: Bool = false
    
    init() {
        getUpcomingGames()
        getGameByGenre()
    }
    
    func refresh() {
        getUpcomingGames()
        getGameByGenre()
    }
    
    func getUpcomingGames() {
        loadingUpcomingGamesState = true
        homeUseCase.getUpcomingGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingUpcomingGamesState = false
                }
            }, receiveValue: { games in
                 self.upcomingGames = games
            })
            .store(in: &cancellables)
    }
    
    func getGameByGenre() {
        loadingGamesByGenreState = true
        homeUseCase.getGamesByGenre(genre: genreSelected)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingGamesByGenreState = false
                }
            }, receiveValue: { games in
                self.gameByGenre = games
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
