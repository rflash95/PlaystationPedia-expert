//
//  NetworkService.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/10/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
    func getUpcomingGames() -> AnyPublisher<[GameResult], Error>
    func getGamesByGenre(genre: String) -> AnyPublisher<[GameResult], Error>
    func searchGame(keyword: String) -> AnyPublisher<[GameResult], Error>
    func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailResponse, Error>
    func getPublishers() -> AnyPublisher<[PublisherResult], Error>
    func getPublisherDetail(publisherId: Int) -> AnyPublisher<PublisherDetailResponse, Error>
}

final class RemoteDataSource: NSObject {
    private override init() {}
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {

    func getUpcomingGames()-> AnyPublisher<[GameResult], Error> {
        return Future<[GameResult], Error> { completion in
            let endpoint = Endpoints.Gets.upcommingGames
            AF.request(endpoint.url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
        }.eraseToAnyPublisher()
    }
    
    func getGamesByGenre(genre: String) -> AnyPublisher<[GameResult], Error> {
        return Future<[GameResult], Error> { completion in
            let endpoint = Endpoints.Gets.gamesByGenre(genre: genre)
            AF.request(endpoint.url)
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.results))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func searchGame(keyword: String) -> AnyPublisher<[GameResult], Error> {
        return Future<[GameResult], Error> { completion in
            let endpoint = Endpoints.Gets.searchGame(keyword: keyword)
            AF.request(endpoint.url)
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.results))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse, Error> { completion in
            let endpoint = Endpoints.Gets.gameDetail(gameId: gameId)
            AF.request(endpoint.url)
                .validate()
                .responseDecodable(of: GameDetailResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func getPublishers() -> AnyPublisher<[PublisherResult], Error> {
        return Future<[PublisherResult], Error> { completion in
            let endpoint = Endpoints.Gets.publishers
            AF.request(endpoint.url)
                .validate()
                .responseDecodable(of: PublisherResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.results))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func getPublisherDetail(publisherId: Int) -> AnyPublisher<PublisherDetailResponse, Error> {
        return Future<PublisherDetailResponse, Error> { completion in
            let endpoint = Endpoints.Gets.publisherDetail(publisherId: publisherId)
            AF.request(endpoint.url)
                .validate()
                .responseDecodable(of: PublisherDetailResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
}
