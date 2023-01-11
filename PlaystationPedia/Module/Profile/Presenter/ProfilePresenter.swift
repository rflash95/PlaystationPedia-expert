//
//  ProfilePresenter.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/01/23.
//


import SwiftUI
import Combine

class ProfilePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    @Inject
    private var profileUseCase: ProfileUseCase
    
    
    @Published var showingSheet = false
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    func getProfile() {
        loadingState = true
        profileUseCase.getProfile()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { profile in
                self.name = profile.name
                self.email = profile.email
            })
            .store(in: &cancellables)
    }
    
    func saveProfile() {
        loadingState = true
        profileUseCase.saveProfile(profile: ProfileModel(name: self.name, email: self.email))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &cancellables)
    }
    
    func synchronize() {
        loadingState = true
        profileUseCase.synchronize()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &cancellables)
    }
}
