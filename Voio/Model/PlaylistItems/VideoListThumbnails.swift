
import Foundation

struct VideoListThumbnails : Codable {
	let defaults : VideoListDefault?
	let medium : VideoListMedium?
	let high : VideoListHigh?
	let standard : VideoListStandard?
	let maxres : VideoListMaxres?

	enum CodingKeys: String, CodingKey {

		case defaults = "default"
		case medium = "medium"
		case high = "high"
		case standard = "standard"
		case maxres = "maxres"
	}

}
