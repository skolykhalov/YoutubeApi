//
//  BannerDataViewController.swift
//  Voio
//
//  Created by Stas on 05.10.2022.
//

import UIKit
import SDWebImage

class BannerDataViewController: UIViewController {

    @IBOutlet weak var bannerImageButton: UIButton!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelSubscribersLabel: UILabel!
    

    private var playlistIdKey: String = ""
    private var videoId: String = ""
    var index: Int?
    var channelId: String = ""
    var videoDelegate: VideoPlayer?
    var bannerDataVCViewModel = BannerDataVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerDataVCViewModel.getChannelData(channelId: channelId) {
            
            if let subscribersCount = Int(self.bannerDataVCViewModel.youtubeChannelArray.first?.statistics?.subscriberCount ?? "") {
                if let number = Formatter.formatter.string(from: subscribersCount as NSNumber) {
                    self.channelSubscribersLabel.text = "\(number) подписчика"
                }
            }
            self.channelTitleLabel.text = self.bannerDataVCViewModel.youtubeChannelArray.first?.snippet?.title
            self.loadBannerImage()
            self.playlistIdKey = self.bannerDataVCViewModel.youtubeChannelArray.first?.contentDetails?.relatedPlaylists?.uploads ?? ""
        }
       
    }
    
    @IBAction func bannerImageButtonPressed(_ sender: UIButton) {
        
        bannerDataVCViewModel.getPlaylistData(playlistId: self.playlistIdKey) { [self] in
            
            videoId = bannerDataVCViewModel.youtubePlaylistArray.first?.contentDetails?.videoId ?? ""
            videoDelegate?.getPlayList(id: playlistIdKey, playlist: bannerDataVCViewModel.youtubePlaylistArray)
            
            bannerDataVCViewModel.getVideoData(videoId: videoId) { [self] in
                
                let title = bannerDataVCViewModel.videoData.first?.snippet?.title ?? ""
                
                if let viewCount = Int(bannerDataVCViewModel.videoData.first?.statistics?.viewCount ?? "") {
                    
                    if let number = Formatter.formatter.string(from: viewCount as NSNumber) {
                        videoDelegate?.setTheView(title: title, views: "\(number) просмотра")
                    }
                }
            }
        }
        
        videoDelegate?.openHidePlayerView()
    }
    
    func loadBannerImage() {
        
        guard let stringUrl = bannerDataVCViewModel.youtubeChannelArray.first?.snippet?.thumbnails?.high?.url else { return }
        guard let fullImageURL = URL(string: stringUrl) else { return }
        bannerImageButton.sd_setImage(with: fullImageURL, for: .normal)
    }
    
}
