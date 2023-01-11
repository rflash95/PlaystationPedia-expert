import Foundation

// MARK: - PublisherDetailResponse
struct PublisherDetailResponse: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case description
    }
}
