//
//  APICall.swift
//  PlaystationPedia
//
//  Created by rzamau on 18/12/22.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/"
    static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "rawg-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'rawg-Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'rawg-Info.plist'.")
            }
            return value
        }
    }
}

protocol Endpoint {
    var url: URLComponents { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case upcommingGames
        case gamesByGenre(genre: String)
        case searchGame(keyword: String)
        case gameDetail(gameId: Int)
        case publishers
        case publisherDetail(publisherId: Int)
        
        public var url: URLComponents {
            switch self {
            case .upcommingGames:
                var components = URLComponents(string: "\(API.baseUrl)games")!
                components.queryItems = [
                    URLQueryItem(name: "key", value: API.apiKey),
                    URLQueryItem(name: "parent_platforms", value: "2"),
                    URLQueryItem(name: "ordering", value: "-released")
                ]
                return components
            case .gamesByGenre(genre: let genre):
                var components = URLComponents(string: "\(API.baseUrl)games")!
                components.queryItems = [
                    URLQueryItem(name: "key", value: API.apiKey),
                    URLQueryItem(name: "parent_platforms", value: "2"),
                    URLQueryItem(name: "genres", value: genre)
                ]
                return components
            case .searchGame(keyword: let keyword):
                var components = URLComponents(string: "\(API.baseUrl)games")!
                components.queryItems = [
                    URLQueryItem(name: "key", value: API.apiKey),
                    URLQueryItem(name: "parent_platforms", value: "2"),
                    URLQueryItem(name: "search", value: keyword)
                ]
                return components
            case .gameDetail(gameId: let gameId):
                var components = URLComponents(string: "\(API.baseUrl)games/\(gameId)")!
                components.queryItems = [
                  URLQueryItem(name: "key", value: API.apiKey)
                ]
                return components
            case .publishers:
                var components = URLComponents(string: "\(API.baseUrl)publishers")!
                components.queryItems = [
                  URLQueryItem(name: "key", value: API.apiKey)
                ]
                return components
            case .publisherDetail(publisherId: let publisherId):
                var components = URLComponents(string: "\(API.baseUrl)publishers/\(publisherId)")!
                components.queryItems = [
                  URLQueryItem(name: "key", value: API.apiKey)
                ]
                return components
            }
        }
    }
}
