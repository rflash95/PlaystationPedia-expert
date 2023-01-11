import Foundation

// MARK: - PublisherResponse
struct PublisherResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PublisherResult]
}

// MARK: - PublisherResult
struct PublisherResult: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let games: [PublisherGame]

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case games
    }
}

// MARK: - PublisherGame
struct PublisherGame: Codable {
    let id: Int
    let slug, name: String
    let added: Int
}
