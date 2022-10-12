
import Foundation

struct RelatedPlaylists : Codable {
	let likes : String?
	let uploads : String?

	enum CodingKeys: String, CodingKey {

		case likes = "likes"
		case uploads = "uploads"
	}

}
