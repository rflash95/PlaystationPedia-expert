//
//  UserDefaultsDataSource.swift
//  PlaystationPedia
//
//  Created by rzamau on 08/01/23.
//

import Foundation
import Combine


protocol UserDefaultDataSourceProtocol: class {
    func saveProfile(for profile: ProfileModel) -> AnyPublisher<Bool, Error>
    func deleteAll() -> AnyPublisher<Bool, Error>
    func getProfile() -> AnyPublisher<ProfileModel, Error>
    func synchronize() -> AnyPublisher<Bool, Error>
}

final class UserDefaultsDataSource: NSObject {
    let nameKey = "name"
    let emailKey = "email"
    
    private override init() {}
    static let sharedInstance: UserDefaultsDataSource = UserDefaultsDataSource()
}


extension UserDefaultsDataSource: UserDefaultDataSourceProtocol {

    func saveProfile(for profile: ProfileModel) -> AnyPublisher<Bool, Error> {
        return Future { completion in
            UserDefaults.standard.set(profile.name, forKey: self.nameKey)
            UserDefaults.standard.set(profile.email, forKey: self.emailKey)
            completion(.success(true))
        }.eraseToAnyPublisher()
    }
    
    func deleteAll() -> AnyPublisher<Bool, Error> {
        return Future { completion in
            if let domain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: domain)
                self.synchronize()
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        }.eraseToAnyPublisher()
    }
    
    func getProfile() -> AnyPublisher<ProfileModel, Error> {
        return Future { completion in
            let name = UserDefaults.standard.string(forKey: self.nameKey) ?? "Reza Maulana"
            let email = UserDefaults.standard.string(forKey: self.emailKey) ?? "reflash95@gmail.com"
            let model = ProfileModel(name: name, email: email)
            completion(.success(model))
        }.eraseToAnyPublisher()
    }
    
    func synchronize() -> AnyPublisher<Bool, Error> {
        return Future { completion in
            UserDefaults.standard.synchronize()
            completion(.success(true))
        }.eraseToAnyPublisher()
    }
}
