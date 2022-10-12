
import Foundation

struct Statistics : Codable {
	let viewCount : String?
	let subscriberCount : String?
	let hiddenSubscriberCount : Bool?
	let videoCount : String?

	enum CodingKeys: String, CodingKey {

		case viewCount = "viewCount"
		case subscriberCount = "subscriberCount"
		case hiddenSubscriberCount = "hiddenSubscriberCount"
		case videoCount = "videoCount"
	}

}
