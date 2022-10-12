
import Foundation

struct VideoThumbnails : Codable {
	let defaults : VideoDefault?
	let medium : VideoMedium?
	let high : VideoHigh?
	let standard : VideoStandard?
	let maxres : VideoMaxres?

	enum CodingKeys: String, CodingKey {

		case defaults = "default"
		case medium = "medium"
		case high = "high"
		case standard = "standard"
		case maxres = "maxres"
	}

}
