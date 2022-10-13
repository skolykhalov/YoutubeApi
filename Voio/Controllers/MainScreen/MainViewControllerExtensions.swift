//
//  MainViewControllerExtensions.swift
//  Voio
//
//  Created by Stas on 11.10.2022.
//

import UIKit


//MARK: - TableView Methods

extension MainViewController: UITableViewDataSource, UITableViewDelegate, VideoPlayer {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        header.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: header.frame.size.width, height: header.frame.size.height))
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = mainViewControllerViewModel.collectionData[section].first?.snippet?.channelTitle
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainViewControllerViewModel.collectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var index: [Int] = []
        index.append(indexPath.section)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configureCell(with: mainViewControllerViewModel.collectionData[indexPath.section], index: index[indexPath.row])
        cell.backgroundColor = .clear
        cell.videoDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var heigh: CGFloat
        if indexPath.section == 0 {
            heigh = 130
        } else {
            heigh = 200
        }
        
        return heigh
    }
    
    
    //MARK: - PlayerView Delegate Methods
    
    func getVideoId(id: String) {
        videoPlayerView.load(withVideoId: id)
    }
    
    func getPlayList(id: String, playlist: [VideoListItems]) {
        playListId = id
        playlistVideoArray = playlist
        videoPlayerView.load(withPlaylistId: id)
    }
    
    func setTheView(title: String, views: String) {
        titleLabel.text = title
        viewsCountLabel.text = views
    }
    
    func openHidePlayerView() {
        
        if isPlayerViewShown {
            
            UIView.animate(withDuration: 0.3) {
                self.popUpViewHeightConstraint.constant = 50
                self.view.layoutIfNeeded()
            } completion: { status in
                self.isPlayerViewShown = false
                self.popUpButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
            }
            
        } else {
            
            UIView.animate(withDuration: 0.1) {
                self.popUpViewHeightConstraint.constant = 800
                self.view.layoutIfNeeded()
            } completion: { status in
                self.isPlayerViewShown = true
                self.popUpButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
            }
            
            UIView.animate(withDuration: 0.1) {
                self.popUpViewHeightConstraint.constant = 750
                self.view.layoutIfNeeded()
            } completion: { status in
            }
        }
    }
}


//MARK: - UIPageViewController Methods

extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return Constants.dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? BannerDataViewController
        
        guard var currentIndex = dataViewController?.index else { return nil }
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? BannerDataViewController
        
        guard var currentIndex = dataViewController?.index else { return nil }
        
        if currentIndex == Constants.dataSource.count {
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func configurePageViewController() {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 250))
        header.backgroundColor = .clear
        tableView.tableHeaderView = header
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else { return }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(pageViewController.view)

        let views: [String: Any] = ["pageView": pageViewController.view as Any]
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else { return }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [self] _ in
            
            if currentViewControllerIndex == Constants.dataSource.count - 1 {
                currentViewControllerIndex = 0
            } else {
                currentViewControllerIndex += 1
            }
            guard let nextVC = detailViewControllerAt(index: currentViewControllerIndex) else { return }
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
        })
    }
    
    func detailViewControllerAt(index: Int) -> BannerDataViewController? {
        
        if index >= Constants.dataSource.count || Constants.dataSource.count == 0 {
            return nil
        }
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: BannerDataViewController.self)) as? BannerDataViewController else { return nil }
        dataViewController.index = index
        dataViewController.videoDelegate = self
        dataViewController.channelId = Constants.dataSource[index]
        
        return dataViewController
    }
}
