//
//  BannerDataViewControllerViewModel.swift
//  Voio
//
//  Created by Stas on 13.10.2022.
//

import Foundation

class BannerDataVCViewModel {
    
    var youtubeChannelArray: [Items] = []
    var youtubePlaylistArray: [VideoListItems] = []
    var videoData: [VideoItems] = []
    
    func getChannelData(channelId: String, completion: @escaping(()->())) {
        
        let channelUrl = Constants.youtubeUrl + "channels?part=snippet,statistics,contentDetails&id=\(channelId)&key=" + Constants.apiKey
        
        NetworkManager().parceYoutubeData(url: channelUrl) { (responceData: ChannelModel) in
            
            self.youtubeChannelArray = responceData.items ?? []
            completion()
        }
    }
    
    func getPlaylistData(playlistId: String, completion: @escaping(()->())) {

        let playlistUrl = Constants.youtubeUrl + "playlistItems?part=id,snippet,contentDetails&key=\(Constants.apiKey)&playlistId=\(playlistId)&maxResults=10"

        NetworkManager().parceYoutubeData(url: playlistUrl) { (responceData: VideoListModel) in

            self.youtubePlaylistArray = responceData.items ?? []
            completion()
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
