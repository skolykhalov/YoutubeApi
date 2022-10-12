
import Foundation

struct VideoListPageInfo : Codable {
	let totalResults : Int?
	let resultsPerPage : Int?

	enum CodingKeys: String, CodingKey {

		case totalResults = "totalResults"
		case resultsPerPage = "resultsPerPage"
	}

}
