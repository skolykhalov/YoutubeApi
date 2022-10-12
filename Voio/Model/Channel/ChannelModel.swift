
import Foundation

struct ChannelModel : Codable {
    
	let kind : String?
	let etag : String?
	let pageInfo : PageInfo?
	let items : [Items]?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case etag = "etag"
		case pageInfo = "pageInfo"
		case items = "items"
	}

}
