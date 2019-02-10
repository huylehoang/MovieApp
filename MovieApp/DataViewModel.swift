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
    
    lazy private var items: [ListItem] = {
        return [ListItem]()
    }()
    lazy private var movieList: MovieListBuilder = {
        return MovieListBuilder()
    }()
    private var selectedVideo: SelectedItem!

    public func setEndpoint(_ endpoint: String, completion: @escaping ((Int?)->())) {
        fetchData(with: endpoint) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getMovieListItem()
            completion(strongSelf.getSelectedIndex())
        }
    }
    
    private func getSelectedIndex() -> Int? {
        return MovieListBridge.getSelectedIndex(from: self.movieList, with: self.selectedVideo)
    }
    
    private func getCurrentList() -> [Video] {
        return self.movieList.getNeedMapList()
    }
    
    private func fetchData(with endpoint: String, completion: @escaping (()->())) {
        if endpoint != "" {
            let fetchProxy = FetchMovieProxy()
            fetchProxy.fetchDataMovie(with: endpoint) { [weak self] (data) in
                guard let strongSelf = self else { return }
                let newData = data.map{ $0 }
                strongSelf.movieList.setOrigin(newData)
                completion()
            }
        }
    }
    
    private func getOriginVideos() -> [Video] {
        return self.movieList.buildOrigin()
    }
    
    public func filterVideos(with filter: String, completion: @escaping (()->())) {
        search(with: filter)
        completion()
    }
    
    private func search(with text: String) {
        let filterCommand = FilterVideoCommand(videos: self.getOriginVideos())
        self.movieList.setFiltered(filterCommand.execute(with: text),
                                   while: isSearchingVideos(text))
        getMovieListItem()
    }
    
    private func isSearchingVideos(_ text: String) -> Bool {
        return (text == "") ? false : true
    }
    
    public func getMovieListCount() -> Int {
        return self.items.count
    }
    
    private func getMovieListItem() {
        MovieListBridge.getMovieListItem(from: self.movieList) { [weak self] (items) in
            guard let strongSelf = self else { return }
            strongSelf.items = items
        }
    }
    
    public func getItemBy(_ index: Int) -> ListItem? {
        return checkIndexIsInRange(index, with: self.getMovieListCount()) ? items[index] : nil
    }
    
    public func selectVideo(at index: Int, completion: @escaping (()->())) {
        selected(at: index) {
            completion()
        }
    }
    
    private func selected(at index: Int, completion: @escaping (()->())) {
        let currentList = self.getCurrentList()
        if checkIndexIsInRange(index, with: currentList.count) {
            MovieListBridge.getSelectedItem(from: self.movieList, with: index) { (selectedItem) in
                self.selectedVideo = selectedItem
                completion()
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

