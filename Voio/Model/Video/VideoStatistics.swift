
import Foundation

struct VideoStatistics : Codable {
	let viewCount : String?
	let likeCount : String?
	let favoriteCount : String?
	let commentCount : String?

	enum CodingKeys: String, CodingKey {

		case viewCount = "viewCount"
		case likeCount = "likeCount"
		case favoriteCount = "favoriteCount"
		case commentCount = "commentCount"
	}


}
