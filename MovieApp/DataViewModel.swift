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
        resetSelected()
        fetchData(with: endpoint) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getMovieListItem()
            completion()
        }
    }
    
    private func resetSelected() {
        if selectedVideo != nil {
            selectedVideo = nil
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
    
    private func getItemsCount() -> Int {
        return self.items.count
    }
    
    public func getItemBy(_ index: Int) -> ListItem? {
        return checkIndexIsInRange(index, with: self.getItemsCount()) ? items[index] : nil
    }
    
    public func selectVideo(at index: Int, completion: @escaping (()->())) {
        selected(at: index) {
            completion()
        }
    }
    
    private func selected(at index: Int, completion: @escaping (()->())) {
        let currentList = self.movieList.getNeedMapList()
        if checkIndexIsInRange(index, with: currentList.count) {
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

