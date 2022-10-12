
import Foundation

struct VideoSnippet : Codable {
	let publishedAt : String?
	let channelId : String?
	let title : String?
	let description : String?
	let thumbnails : VideoThumbnails?
	let channelTitle : String?
	let tags : [String]?
	let categoryId : String?
	let liveBroadcastContent : String?
	let localized : VideoLocalized?
	let defaultAudioLanguage : String?

	enum CodingKeys: String, CodingKey {

		case publishedAt = "publishedAt"
		case channelId = "channelId"
		case title = "title"
		case description = "description"
		case thumbnails = "thumbnails"
		case channelTitle = "channelTitle"
		case tags = "tags"
		case categoryId = "categoryId"
		case liveBroadcastContent = "liveBroadcastContent"
		case localized = "localized"
		case defaultAudioLanguage = "defaultAudioLanguage"
	}


}
