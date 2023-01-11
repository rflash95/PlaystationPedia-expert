// MARK: - ScreenshotResponse
struct ScreenshotResponse: Codable {
    let count: Int
    let next, previous: String?
    let results: [ScreenshotResult]
}

// MARK: - ScreenshotResult
struct ScreenshotResult: Codable {
    let id: Int
    let image: String
    let width, height: Int
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, image, width, height
        case isDeleted = "is_deleted"
    }
}
