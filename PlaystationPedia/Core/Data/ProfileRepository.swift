//
//  ProfileRepository.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import Combine

protocol ProfileRepositoryProtocol {
    func getProfile() -> AnyPublisher<ProfileModel, Error>
    func saveProfile(profile: ProfileModel) -> AnyPublisher<Bool, Error>
    func synchronize() -> AnyPublisher<Bool, Error>
}

final class ProfileRepository: NSObject {
    typealias ProfileInstance = (UserDefaultsDataSource) -> ProfileRepository
    fileprivate let userDefaults: UserDefaultsDataSource
    private init(userDefaults: UserDefaultsDataSource) {
        self.userDefaults = userDefaults
    }
    static let sharedInstance: ProfileInstance = { userDefaultRepo in
        return ProfileRepository(userDefaults: userDefaultRepo)
    }
}

extension ProfileRepository: ProfileRepositoryProtocol {
    func getProfile() -> AnyPublisher<ProfileModel, Error> {
        return self.userDefaults.getProfile().eraseToAnyPublisher()
    }
    
    func saveProfile(profile: ProfileModel) -> AnyPublisher<Bool, Error> {
        return self.userDefaults.saveProfile(for: profile).eraseToAnyPublisher()
    }
    
    func synchronize() -> AnyPublisher<Bool, Error> {
        return self.userDefaults.synchronize()
    }
}

