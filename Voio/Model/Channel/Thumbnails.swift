
import Foundation

struct Thumbnails : Codable {
	let defaults : Default?
	let medium : Medium?
	let high : High?

	enum CodingKeys: String, CodingKey {

		case defaults = "default"
		case medium = "medium"
		case high = "high"
	}

}
