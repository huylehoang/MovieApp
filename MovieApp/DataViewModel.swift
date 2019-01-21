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
    private var items = [ListItem]()
    private var selectedVideo: SelectedItem!
    private var isSearching = false
    
    public func setEndpoint(_ endpoint: String, completion: @escaping (()->())) {
        fetchData(with: endpoint) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getMovieListItem()
            completion()
        }
    }
    
    private func fetchData(with endpoint: String, completion: @escaping (()->())) {
        if endpoint != "" {
            let fetchProxy = FetchMovieProxy()
            fetchProxy.fetchDataMovie(with: endpoint) { [weak self] (data) in
                guard let strongSelf = self else { return }
                strongSelf.videos = data.map{ $0 }
                completion()
            }
        }
    }
    
    public func filterVideos(with filter: String, completion: @escaping (()->())) {
        let filterCommand = FilterVideoCommand(videos: self.videos)
        self.isSearching = (filter == "") ? false : true
        filteredVideos = filterCommand.execute(with: filter)
        getMovieListItem()
        completion()
    }
    
    public func getMovieListCount() -> Int {
        return self.items.count
    }

    private func getMovieListItem() {
        let movieList = MovieList(origin: self.videos, filtered: self.filteredVideos)
        MovieListBridge.getMovieListItem(from: movieList, while: self.isSearching) { [weak self] (items) in
            guard let strongSelf = self else { return }
            strongSelf.items = items
        }
    }
    
    public func getItemBy(_ index: Int) -> ListItem? {
        return checkIndexIsInRange(index, with: self.items.count) ? items[index] : nil
    }
    
    public func selectVideo(at index: Int, completion: @escaping (()->())) {
        if checkIndexIsInRange(index, with: self.items.count) {
            if let video = videos.filter({ (video) -> Bool in
                return video.id == items[index].id
            }).first {
                Helper.mapSelectedItem(from: video) { (selected) in
                    self.selectedVideo = selected
                    completion()
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

