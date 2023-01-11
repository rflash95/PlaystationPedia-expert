//
//  ProfileInteractor.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/01/23.
//

import Foundation
import Combine

protocol ProfileUseCase {
    func getProfile() -> AnyPublisher<ProfileModel, Error>
    func saveProfile(profile: ProfileModel) -> AnyPublisher<Bool, Error>
    func synchronize() -> AnyPublisher<Bool, Error>
}

class ProfileInteractor: ProfileUseCase {
    private let repository: ProfileRepositoryProtocol
    required init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProfile() -> AnyPublisher<ProfileModel, Error> {
        return repository.getProfile()
    }
    
    func saveProfile(profile: ProfileModel) -> AnyPublisher<Bool, Error> {
        return repository.saveProfile(profile: profile)
    }
    
    func synchronize() -> AnyPublisher<Bool, Error> {
        return repository.synchronize()
    }
}
