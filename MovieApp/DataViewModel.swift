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
    
    private var items = [ListItem]()
    private var selectedVideo: SelectedItem!
    private var movieList = MovieListBuilder()
    
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
                let newData = data.map{ $0 }
                strongSelf.movieList.setOrigin(newData)
                completion()
            }
        }
    }
    
    public func filterVideos(with filter: String, completion: @escaping (()->())) {
        search(with: filter)
        completion()
    }
    
    private func search(with text: String) {
        let filterCommand = FilterVideoCommand(videos: self.movieList.buildOrigin())
        self.movieList.setFiltered(filterCommand.execute(with: text),
                                   while: (text == "") ? false : true)
        getMovieListItem()
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
        return checkIndexIsInRange(index, with: self.items.count) ? items[index] : nil
    }
    
    public func selectVideo(at index: Int, completion: @escaping (()->())) {
        selected(at: index) {
            completion()
        }
    }
    
    private func selected(at index: Int, completion: @escaping (()->())) {
        if checkIndexIsInRange(index, with: self.items.count) {
            let currentList = self.movieList.getNeedMapList()
            Helper.mapSelectedItem(from: currentList[index]) { (selected) in
                self.selectedVideo = selected
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

