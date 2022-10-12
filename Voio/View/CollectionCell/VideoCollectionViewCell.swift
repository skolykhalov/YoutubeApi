//
//  VideoCollectionViewCell.swift
//  Voio
//
//  Created by Stas on 08.10.2022.
//

import UIKit
import SDWebImage

class VideoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "VideoCollectionViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "VideoCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func configureCell(with model: VideoListItems) {
        
        titleLabel.text = model.snippet?.title
        loadPosterImage(imagePath: model.snippet?.thumbnails?.medium?.url ?? "")
    }
    
    func loadPosterImage(imagePath: String) {
        
        guard let fullImageURL = URL(string: imagePath) else { return }
        posterImageView.sd_setImage(with: fullImageURL)
    }

}
