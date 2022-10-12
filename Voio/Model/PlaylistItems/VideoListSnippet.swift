
import Foundation

struct VideoListSnippet : Codable {
	let publishedAt : String?
	let channelId : String?
	let title : String?
	let description : String?
	let thumbnails : VideoListThumbnails?
	let channelTitle : String?
	let playlistId : String?
	let position : Int?
	let resourceId : VideoListResourceId?
	let videoOwnerChannelTitle : String?
	let videoOwnerChannelId : String?

	enum CodingKeys: String, CodingKey {

		case publishedAt = "publishedAt"
		case channelId = "channelId"
		case title = "title"
		case description = "description"
		case thumbnails = "thumbnails"
		case channelTitle = "channelTitle"
		case playlistId = "playlistId"
		case position = "position"
		case resourceId = "resourceId"
		case videoOwnerChannelTitle = "videoOwnerChannelTitle"
		case videoOwnerChannelId = "videoOwnerChannelId"
	}

}
