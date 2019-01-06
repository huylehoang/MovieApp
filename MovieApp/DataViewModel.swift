//
//  DataModel.swift
//  MovieApp
//
//  Created by LeeX on 7/24/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import Foundation
import UIKit

class DataViewModel {

    private var videos = [Video]()
    private var filteredVideos = [Video]()
    private var listCount: Int = 0
    private var items = [ListItem]()
    private var selectedVideo: SelectedItem!
    private var isSearching = false
    
    public func setEndpoint(_ endpoint: String, completion: (()->())? = nil) {
        fetchData(with: endpoint) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getMovieListItem()
            completion?()
        }
    }
    
    private func fetchData(with endpoint: String, completion: (()->())?) {
        if endpoint != "" {
            ApiClient.shared().fetchDataMovie(with: endpoint) { [weak self] (data) in
                guard let strongSelf = self else { return }
                strongSelf.videos = data.map{ $0 }
                completion?()
            }
            
        }
    }
    
    public func filterVideos(with filter: String, completion: (()->())? = nil) {
        let filterCommand = FilterVideoCommand(videos: self.videos)
        self.isSearching = (filter == "") ? false : true
        filteredVideos = filterCommand.execute(with: filter)
        getMovieListItem()
        completion?()
    }
    
    public func getMovieListCount() -> Int {
        return self.listCount
    }

    private func getMovieListItem() {
        VideoFactory.getMovieListItem(from: self.videos, and: self.filteredVideos, while: self.isSearching) { [weak self] (items) in
            guard let strongSelf = self else { return }
            strongSelf.items = items
            strongSelf.listCount = items.count
        }
    }
    
    public func getItemBy(_ index: Int) -> ListItem? {
        return (index < self.listCount) ? items[index] : nil
    }
    
    public func selectVideo(at index: Int, completion: (()->())?) {
        if checkIndexIsInRange(index, with: listCount) {
            if let video = videos.filter({ (video) -> Bool in
                return video.id == items[index].id
            }).first {
                Helper.mapSelectedItem(from: video) { (selected) in
                    self.selectedVideo = selected
                    completion?()
                }
            }
        }
    }
    
    public func getSelectedVideo() -> SelectedItem? {
        return (self.selectedVideo != nil) ? self.selectedVideo : nil
    }
    
    private func checkIndexIsInRange(_ index: Int, with range: Int) -> Bool {
        return (index < range) ? true : false
    }
}

