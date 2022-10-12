//
//  MainViewControllerViewModel.swift
//  Voio
//
//  Created by Stas on 11.10.2022.
//

import Foundation

class MainViewControllerViewModel {
    
    var collectionData: [[VideoListItems]] = []
    var firstPlaylistArray: [VideoListItems] = []
    var secondPlaylistArray: [VideoListItems] = []
    var videoData: [VideoItems] = []
    
    //MARK: - Get Playlist Data
    
    func getFirstPlaylistData(completion: @escaping(()->())) {
        
        let playlistUrl = Constants.youtubeUrl + "playlistItems?part=id,snippet,contentDetails&key=\(Constants.apiKey)&playlistId=\(Constants.firstPlaylistId)&maxResults=10"
        
        NetworkManager().parceYoutubeData(url: playlistUrl) { (responceData: VideoListModel) in
            
            self.firstPlaylistArray = responceData.items ?? []
            self.collectionData.append(self.firstPlaylistArray)
            completion()
        }
    }
    
    func getSecondPlaylistData(completion: @escaping(()->())) {
        
        let playlistUrl = Constants.youtubeUrl + "playlistItems?part=id,snippet,contentDetails&key=\(Constants.apiKey)&playlistId=\(Constants.secondPlaylistId)&maxResults=10"
        
        NetworkManager().parceYoutubeData(url: playlistUrl) { (responceData: VideoListModel) in
            
            self.secondPlaylistArray = responceData.items ?? []
            self.collectionData.append(self.secondPlaylistArray)
            completion()
        }
    }
    
    //MARK: - Get VideoData
    
    func getVideoData(videoId: String, completion: @escaping(()->())) {

        let videoUrl = Constants.youtubeUrl + "videos?id=\(videoId)&part=snippet,statistics&key=" + Constants.apiKey

        NetworkManager().parceYoutubeData(url: videoUrl) { (responceData: VideoModel) in

            self.videoData = responceData.items ?? []
            completion()
        }
    }
    
}
