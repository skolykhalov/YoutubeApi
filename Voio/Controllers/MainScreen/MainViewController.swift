//
//  NewViewController.swift
//  Voio
//
//  Created by Stas on 08.10.2022.
//

import UIKit
import youtube_ios_player_helper
import MediaPlayer

protocol VideoPlayer {
    func getVideoId(id: String)
    func getPlayList(id: String, playlist: [VideoListItems])
    func setTheView(title: String, views: String)
    func openHidePlayerView()
}


class MainViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var popUpViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerSlider: UISlider!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playerControlStackView: UIStackView!
    @IBOutlet weak var volumeView: UIView!
    
    var currentViewControllerIndex = 0
    var videoIndex = 0
    var timer: Timer?
    var isPlayerViewShown = false
    private var isPlaying = false
    var videoIsSelected = false
    var mainViewControllerViewModel = MainViewControllerViewModel()
    var playListId = ""
    var playlistVideoArray: [VideoListItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoPlayerView.delegate = self
        
        configureView()
        
        configurePageViewController()
        
        mainViewControllerViewModel.getPlaylistData(playlistId1: Constants.firstPlaylistId, playlistId2: Constants.secondPlaylistId) {
            self.tableView.reloadData()
        }
        customSlider()
    }
    
    func configureView() {
        
        popUpView.layer.cornerRadius = 20
        popUpView.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor, UIColor.blue.cgColor]
        popUpView.layer.insertSublayer(gradientLayer, at: 0)
        
        playerSlider.setThumbImage(UIImage(named: "ThumbIcon"), for: .normal)
        
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
    }
    
    func customSlider() {
        
        let myVolumeView = MPVolumeView(frame: CGRect(x: 0, y: 0, width: volumeView.frame.width * 0.9, height: 30))
        
        myVolumeView.showsRouteButton = false
        
        volumeView.addSubview(myVolumeView)
        
            let temp = myVolumeView.subviews
            for current in temp {
                if current.isKind(of: UISlider.self) {
                    let tempSlider = current as! UISlider
                    tempSlider.minimumTrackTintColor = .white
                    tempSlider.maximumTrackTintColor = .lightGray
                    tempSlider.minimumValueImage = UIImage(systemName: "speaker.wave.1.fill")
                    tempSlider.tintColor = .white
                    tempSlider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")
                    
                }
            }
        }
    
    //MARK: - VideoPlayer Methods
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoPlayerView.playVideo()
        isPlaying = true
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        
        var durationVideoTime: Double = 0.0
        var currentVideoTime: Float = 0.0
        
        let currentTimeString = Formatter.timeStringFor(seconds: Int(playTime))
        self.currentTimeLabel.text = "\(currentTimeString)"
        
        self.videoPlayerView.duration { duration, error in
            durationVideoTime = duration
            let timeLeft = Formatter.timeStringFor(seconds: Int(duration) - Int(playTime))
            self.durationLabel.text = "\(timeLeft)"
        }
        
        self.videoPlayerView.currentTime { currentTime, error in
            currentVideoTime = currentTime
            self.playerSlider.value = currentVideoTime / Float(durationVideoTime)
        }
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        
        if isPlaying {
            isPlaying = false
            videoPlayerView.pauseVideo()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        } else {
            isPlaying = true
            videoPlayerView.playVideo()
            
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func nextVideoButtonPressed(_ sender: UIButton) {
        
        if videoIsSelected {
            videoIndex = 0
        } else {
            videoIndex += 1
            setTheVideoLabels()
            videoPlayerView.nextVideo()
        }
        
    }
    
    @IBAction func previousVideoButtonPressed(_ sender: UIButton) {
        
        if videoIndex == 0 {
            videoIndex = 0
        } else {
            videoIndex -= 1
            setTheVideoLabels()
            videoPlayerView.previousVideo()
        }
      
    }
    
    private func setTheVideoLabels() {
        
        guard let videoId = playlistVideoArray[videoIndex].contentDetails?.videoId else { return }
        
        mainViewControllerViewModel.getVideoData(videoId: videoId) {
            
            self.titleLabel.text = self.mainViewControllerViewModel.videoData.first?.snippet?.title ?? ""
            
            if let viewCount = Int(self.mainViewControllerViewModel.videoData.first?.statistics?.viewCount ?? "") {
                if let number = Formatter.formatter.string(from: viewCount as NSNumber) {
                    self.viewsCountLabel.text = "\(number) просмотра"
                }
            }
        }
    }
    
    @IBAction func popUpButtonPressed(_ sender: UIButton) {
        openHidePlayerView()
    }
    
    @IBAction func playerSliderPushed(_ sender: UISlider) {
        
        videoPlayerView.duration { duration, error in
            self.videoPlayerView.seek(toSeconds: sender.value * Float(duration), allowSeekAhead: true)
        }
    }
}


