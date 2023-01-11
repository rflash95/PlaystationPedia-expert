// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gameResponse = try? newJSONDecoder().decode(GameResponse.self, from: jsonData)

import Foundation

// MARK: - GameResponse
struct GameResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameResult]
    let userPlatforms: Bool?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case userPlatforms = "user_platforms"
    }
}

// MARK: - Result
struct GameResult: Codable {
    let slug, name: String
    let playtime: Int
    let platforms: [Platform]
    let stores: [Store]?
    let released: String?
    let tba: Bool
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let suggestionsCount: Int
    let updated: String
    let id: Int
    let tags: [Tag]?
    let esrbRating: EsrbRating?
    let reviewsCount: Int
    let communityRating: Int?
    let shortScreenshots: [ShortScreenshot]
    let parentPlatforms: [Platform]
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case slug, name, playtime, platforms, stores, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic
        case suggestionsCount = "suggestions_count"
        case updated, id, tags
        case esrbRating = "esrb_rating"
        case reviewsCount = "reviews_count"
        case communityRating = "community_rating"
        case shortScreenshots = "short_screenshots"
        case parentPlatforms = "parent_platforms"
        case genres
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let owned: Int?
    let toplay: Int?
    let yet, beaten, playing: Int?
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name, slug, nameEn, nameRu: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case nameEn = "name_en"
        case nameRu = "name_ru"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - Platform
struct Platform: Codable {
    let platform: Genre
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Store
struct Store: Codable {
    let store: Genre
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int
    let name, slug: String
    let language: Language
    let gamesCount: Int
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, language
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

enum Language: String, Codable {
case eng
case rus
}
