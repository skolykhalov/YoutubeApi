
import Foundation

struct VideoModel : Codable {
	let kind : String?
	let etag : String?
	let items : [VideoItems]?
	let pageInfo : VideoPageInfo?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case etag = "etag"
		case items = "items"
		case pageInfo = "pageInfo"
	}

}
