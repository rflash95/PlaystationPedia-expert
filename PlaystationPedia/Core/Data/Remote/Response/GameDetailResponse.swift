// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gameDetailResponse = try? newJSONDecoder().decode(GameDetailResponse.self, from: jsonData)

import Foundation

// MARK: - GameDetailResponse
struct GameDetailResponse: Codable {
    let id: Int
    let slug, name, nameOriginal, gameDetailResponseDescription: String
    let metacritic: Int?
    let metacriticPlatforms: [GameDetailMetacriticPlatform]
    let released: String?
    let tba: Bool
    let updated: String
    let backgroundImage, backgroundImageAdditional: String?
    let website: String
    let rating: Double
    let ratingTop: Int
    let ratings: [GameDetailRating]
    let reactions: [String: Int]?
    let added: Int
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int
    let achievementsCount, parentAchievementsCount: Int
    let redditURL: String
    let redditName, redditDescription, redditLogo: String
    let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int
    let ratingsCount, suggestionsCount: Int
    let alternativeNames: [String]
    let metacriticURL: String
    let parentsCount, additionsCount, gameSeriesCount: Int
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [GameDetailParentPlatform]
    let stores: [GameDetailStore]
    let developers, genres, tags, publishers: [GameDetailDeveloper]
    let esrbRating: GameDetailEsrbRating?
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case gameDetailResponseDescription = "description"
        case metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case ratings, reactions, added
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticURL = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case stores, developers, genres, tags, publishers
        case esrbRating = "esrb_rating"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - GameDetailDeveloper
struct GameDetailDeveloper: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: GameDetailLanguage?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum GameDetailLanguage: String, Codable {
    case eng = "eng"
    case ind = "idn"
}

// MARK: - GameDetailEsrbRating
struct GameDetailEsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - GameDetailMetacriticPlatform
struct GameDetailMetacriticPlatform: Codable {
    let metascore: Int
    let url: String
    let platform: GameDetailMetacriticPlatformPlatform
}

// MARK: - GameDetailMetacriticPlatformPlatform
struct GameDetailMetacriticPlatformPlatform: Codable {
    let platform: Int
    let name, slug: String
}

// MARK: - GameDetailParentPlatform
struct GameDetailParentPlatform: Codable {
    let platform: GameDetailEsrbRating
}

// MARK: - GameDetailPlatformPlatform
struct GameDetailPlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - GameDetailRequirements
struct GameDetailRequirements: Codable {
    let minimum, recommended: String?
}

// MARK: - GameDetailRating
struct GameDetailRating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

// MARK: - GameDetailStore
struct GameDetailStore: Codable {
    let id: Int
    let url: String
    let store: GameDetailDeveloper
}
