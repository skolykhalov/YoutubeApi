
import Foundation

struct VideoListModel : Codable {
	let kind : String?
	let etag : String?
	let nextPageToken : String?
	let items : [VideoListItems]?
	let pageInfo : VideoListPageInfo?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case etag = "etag"
		case nextPageToken = "nextPageToken"
		case items = "items"
		case pageInfo = "pageInfo"
	}

}
