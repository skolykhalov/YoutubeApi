
import Foundation

struct Items : Codable {
	let kind : String?
	let etag : String?
	let id : String?
	let snippet : Snippet?
	let contentDetails : ContentDetails?
	let statistics : Statistics?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case etag = "etag"
		case id = "id"
		case snippet = "snippet"
		case contentDetails = "contentDetails"
		case statistics = "statistics"
	}

}
