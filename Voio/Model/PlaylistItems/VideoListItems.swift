
import Foundation

struct VideoListItems : Codable {
	let kind : String?
	let etag : String?
	let id : String?
	let snippet : VideoListSnippet?
	let contentDetails : VideoListContentDetails?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case etag = "etag"
		case id = "id"
		case snippet = "snippet"
		case contentDetails = "contentDetails"
	}

}
