
import Foundation

struct VideoListContentDetails : Codable {
	let videoId : String?
	let videoPublishedAt : String?

	enum CodingKeys: String, CodingKey {

		case videoId = "videoId"
		case videoPublishedAt = "videoPublishedAt"
	}

}
