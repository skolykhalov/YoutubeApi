
import Foundation

struct Medium : Codable {
	let url : String?
	let width : Int?
	let height : Int?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case width = "width"
		case height = "height"
	}

}
