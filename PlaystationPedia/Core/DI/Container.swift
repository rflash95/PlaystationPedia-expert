//
//  Container.swift
//  PlaystationPedia
//
//  Created by rzamau on 05/01/23.
//

import Foundation
import Swinject
import RealmSwift

func buildContainer() -> Container {
    let container = Container()
    container.register(Realm .self) { _ in
        do {
          return try Realm()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }.inObjectScope(.container)
    
    container.register(LocaleDataSource.self) { register in
        LocaleDataSource.sharedInstance(register.resolve(Realm.self))
    }
    
    container.register(RemoteDataSource.self) { _ in
        RemoteDataSource.sharedInstance
    }
    
    container.register(UserDefaultsDataSource.self) { _ in
        UserDefaultsDataSource.sharedInstance
    }
    
    container.register(GameRepositoryProtocol.self) { register in
        let locale = register.resolve(LocaleDataSource.self)!
        let remote = register.resolve(RemoteDataSource.self)!
        return GameRepository.sharedInstance(locale, remote)
    }
    
    container.register(GameRepositoryProtocol.self) { register in
        let locale = register.resolve(LocaleDataSource.self)!
        let remote = register.resolve(RemoteDataSource.self)!
        return GameRepository.sharedInstance(locale, remote)
    }
    
    container.register(ProfileRepository.self) { register in
        let userDefaults = register.resolve(UserDefaultsDataSource.self)!
        return ProfileRepository.sharedInstance(userDefaults)
    }
    
    container.register(PublisherRepositoryProtocol.self) { register in
        let locale = register.resolve(LocaleDataSource.self)!
        let remote = register.resolve(RemoteDataSource.self)!
        return PublisherRepository.sharedInstance(locale, remote)
    }
    container.register(ProfileRepositoryProtocol.self) { register in
        let userDefaults = register.resolve(UserDefaultsDataSource.self)!
        return ProfileRepository.sharedInstance(userDefaults)
    }
    
    container.register(HomeUseCase.self) { register in
        HomeInteractor(repository: register.resolve(GameRepositoryProtocol.self)!)
    }
    
    container.register(DetailGameUseCase.self) { register in
        DetailGameInteractor(repository: register.resolve(GameRepositoryProtocol.self)!)
    }
    
    container.register(SearchGameUseCase.self) { register in
        SearchGameInteractor(repository: register.resolve(GameRepositoryProtocol.self)!)
    }
    
    container.register(PublisherUseCase.self) { register in
        PublisherInteractor(repository: register.resolve(PublisherRepositoryProtocol.self)!)
    }
    
    container.register(DetailPublisherUseCase.self) { register in
        DetailPublisherInteractor(repository: register.resolve(PublisherRepositoryProtocol.self)!)
    }
    
    container.register(ProfileUseCase.self) { register in
        ProfileInteractor(repository: register.resolve(ProfileRepositoryProtocol.self)!)
    }
    
    container.register(FavoriteUseCase.self) { register in
        FavoriteInteractor(repository: register.resolve(GameRepositoryProtocol.self)!)
    }
    
    return container
}
