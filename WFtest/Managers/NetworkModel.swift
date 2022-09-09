import Foundation

// MARK: - URL model

struct URLs: Codable {
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
}

// MARK: - Search model

struct SearchData: Codable {
    var total_pages: Int?
    var results: [SearchResult]?
}

struct SearchResult: Codable {
    var id: String?
    var urls: URLs?
}

// MARK: - Info model

struct InfoData: Codable {
    var id: String?
    var created_at: String?
    var urls: URLs?
    var user: User?
    var downloads: Int?
}

struct User: Codable {
    var username: String?
    var profile_image: ProfileImage?
    var location: String?
}

struct ProfileImage: Codable {
    var medium: String?
}










