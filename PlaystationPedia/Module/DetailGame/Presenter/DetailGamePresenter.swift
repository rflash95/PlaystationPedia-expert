//
//  DetailGamePresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 07/01/23.
//

import SwiftUI
import Combine

class DetailGamePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var detailGameUseCase: DetailGameUseCase
    private var gameId: Int

    @Published var game: GameModel?
    @Published var isFavorite: Bool = false
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(gameId: Int) {
        self.gameId = gameId
        self.getGame()
        self.getFavorite()
    }
    
    func getGame() {
        loadingState = true
        detailGameUseCase.getGame(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { game in
                self.game = game
            })
            .store(in: &cancellables)
    }
    
    func addFavorite() {
        loadingState = true
        detailGameUseCase.addFavorite(game: game!)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { _ in
                self.isFavorite = true
            })
            .store(in: &cancellables)
    }
    
    func deleteFavorite() {
        loadingState = true
        detailGameUseCase.deleteFavorite(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { _ in
                self.isFavorite = false
            })
            .store(in: &cancellables)
    }

    func getFavorite() {
        loadingState = true
        detailGameUseCase.getFavorite(id: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { _ in
                self.isFavorite = true
            })
            .store(in: &cancellables)
    }
}
