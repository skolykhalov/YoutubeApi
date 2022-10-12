
import Foundation

struct VideoItems : Codable {
	let kind : String?
	let etag : String?
	let id : String?
	let snippet : VideoSnippet?
	let statistics : VideoStatistics?

	enum CodingKeys: String, CodingKey {

		case kind = "kind"
		case etag = "etag"
		case id = "id"
		case snippet = "snippet"
		case statistics = "statistics"
	}

}
