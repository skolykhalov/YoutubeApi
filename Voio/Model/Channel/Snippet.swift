
import Foundation

struct Snippet : Codable {
	let title : String?
	let description : String?
	let customUrl : String?
	let publishedAt : String?
	let thumbnails : Thumbnails?
	let defaultLanguage : String?
	let localized : Localized?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case description = "description"
		case customUrl = "customUrl"
		case publishedAt = "publishedAt"
		case thumbnails = "thumbnails"
		case defaultLanguage = "defaultLanguage"
		case localized = "localized"
		case country = "country"
	}

}
