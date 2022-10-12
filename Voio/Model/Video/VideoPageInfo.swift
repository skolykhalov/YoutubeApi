
import Foundation

struct VideoPageInfo : Codable {
	let totalResults : Int?
	let resultsPerPage : Int?

	enum CodingKeys: String, CodingKey {

		case totalResults = "totalResults"
		case resultsPerPage = "resultsPerPage"
	}

}
