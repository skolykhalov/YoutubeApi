
import Foundation

struct VideoListResourceId : Codable {
	let kind : String?
	let videoId : String?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case videoId = "videoId"
	}

}
