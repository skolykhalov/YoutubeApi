
import Foundation

struct ContentDetails : Codable {
	let relatedPlaylists : RelatedPlaylists?

	enum CodingKeys: String, CodingKey {

		case relatedPlaylists = "relatedPlaylists"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		relatedPlaylists = try values.decodeIfPresent(RelatedPlaylists.self, forKey: .relatedPlaylists)
	}

}
