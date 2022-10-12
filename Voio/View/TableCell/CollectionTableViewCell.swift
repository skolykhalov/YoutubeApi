//
//  CollectionTableViewCell.swift
//  Voio
//
//  Created by Stas on 08.10.2022.
//

import UIKit


class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!

    static let identifier = "CollectionTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    private var videoPlaylistArray: [VideoListItems] = []
    private var index = 0
    private var videoData: [VideoItems] = []
    var videoDelegate: VideoPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(VideoCollectionViewCell.nib(), forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public func configureCell(with model: [VideoListItems], index: Int) {
        
        self.videoPlaylistArray = model
        self.index = index
    }
    
    
    //MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoPlaylistArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let videoId = videoPlaylistArray[indexPath.row].contentDetails?.videoId ?? ""
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        cell.configureCell(with: videoPlaylistArray[indexPath.row])
        
        getVideoData(videoId: videoId) {
            
            if let viewCount = Int(self.videoData.first?.statistics?.viewCount ?? "") {
                if let number = Formatter.formatter.string(from: viewCount as NSNumber) {
                    cell.viewsCountLabel.text = "\(number) просмотра"
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize
        if index == 0 {
            cellSize = CGSize(width: 160, height: 130)
        } else {
            cellSize = CGSize(width: 120, height: 300)
        }
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedVideoId = videoPlaylistArray[indexPath.row].contentDetails?.videoId ?? ""
        let title = videoPlaylistArray[indexPath.row].snippet?.title ?? ""
        
        videoDelegate?.getVideoId(id: selectedVideoId)
        videoDelegate?.openHidePlayerView()
        
        getVideoData(videoId: selectedVideoId) {
           
            if let viewCount = Int(self.videoData.first?.statistics?.viewCount ?? "") {
                
                if let number = Formatter.formatter.string(from: viewCount as NSNumber) {
                    self.videoDelegate?.setTheView(title: title, views: "\(number) просмотра")
                }
            }
        }
    }

    func getVideoData(videoId: String, completion: @escaping(()->())) {

        let videoUrl = Constants.youtubeUrl + "videos?id=\(videoId)&part=snippet,statistics&key=" + Constants.apiKey
        
        NetworkManager().parceYoutubeData(url: videoUrl) { (responceData: VideoModel) in
            
            self.videoData = responceData.items ?? []
            completion()
        }
    }
    
    
}
