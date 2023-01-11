//
//  PublisherRepository.swift
//  PlaystationPedia
//
//  Created by rzamau on 20/12/22.
//
import Foundation
import Combine

protocol PublisherRepositoryProtocol {
    func getPublishers() -> AnyPublisher<[PublisherModel], Error>
    func getPublisherDetail(id: Int) -> AnyPublisher<PublisherModel, Error>
}

final class PublisherRepository: NSObject {
    typealias PublisherInstance = (LocaleDataSource, RemoteDataSource) -> PublisherRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    static let sharedInstance: PublisherInstance = { localeRepo, remoteRepo in
        return PublisherRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension PublisherRepository: PublisherRepositoryProtocol {
    func getPublishers() -> AnyPublisher<[PublisherModel], Error> {
        return self.locale.getPublishers()
            .flatMap { result -> AnyPublisher<[PublisherModel], Error> in
                if result.isEmpty {
                    return self.remote.getPublishers()
                        .map { PublisherMapper.mapPublisherResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addPublishers(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPublishers()
                                .map { PublisherMapper.mapPublisherEntitiesToDomains(input: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.getPublishers()
                        .map {PublisherMapper.mapPublisherEntitiesToDomains(input: $0)}.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getPublisherDetail(id: Int) -> AnyPublisher<PublisherModel, Error> {
        return self.remote.getPublisherDetail(publisherId: id)
            .map { PublisherMapper.mapPublisherDetailResponseToEntity(input: $0) }
            .flatMap { self.locale.addPublisher(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getPublisher(id: id)
                    .map { PublisherMapper.mapPublisherDetailEntityToDomain(input: $0) }
            }.eraseToAnyPublisher()
    }
}
