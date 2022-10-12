
import Foundation

struct Localized : Codable {
	let title : String?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case description = "description"
	}

}
