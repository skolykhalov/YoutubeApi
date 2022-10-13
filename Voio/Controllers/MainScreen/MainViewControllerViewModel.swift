//
//  MainViewControllerViewModel.swift
//  Voio
//
//  Created by Stas on 11.10.2022.
//

import Foundation

class MainViewControllerViewModel {
    
    var collectionData: [[VideoListItems]] = []
    var videoData: [VideoItems] = []
    
    //MARK: - Get Playlist Data
    
    func getPlaylistData(playlistId1: String, playlistId2: String, completion: @escaping(()->())) {
        
        let playlistUrl1 = Constants.youtubeUrl + "playlistItems?part=id,snippet,contentDetails&key=\(Constants.apiKey)&playlistId=\(playlistId1)&maxResults=10"
        
        let playlistUrl2 = Constants.youtubeUrl + "playlistItems?part=id,snippet,contentDetails&key=\(Constants.apiKey)&playlistId=\(playlistId2)&maxResults=10"
        
        NetworkManager().parceYoutubeData(url: playlistUrl1) { (responceData: VideoListModel) in

            self.collectionData.append(responceData.items ?? [])
            completion()
        }
        
        NetworkManager().parceYoutubeData(url: playlistUrl2) { (responceData: VideoListModel) in

            self.collectionData.append(responceData.items ?? [])
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
