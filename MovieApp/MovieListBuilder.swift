//
//  MovieListBuilder.swift
//  
//
//  Created by Huy Le Hoang on 1/31/19.
//

import Foundation

protocol MovieListProtocol {
    var origin: [Video] {get set}
    var filtered: [Video] {get set}
    var isSearching: Bool {get set}
}

class MovieList: MovieListProtocol {
    var origin: [Video] = []
    var filtered: [Video] = []
    var isSearching: Bool = false
}

protocol MovieListBuilderProtocol {
    func buildOrigin() -> [Video]
    func setFiltered(_ filtered: [Video], while searching: Bool)
    func setOrigin(_ origin: [Video])
    func getNeedMapList() -> [Video]
}

protocol SelectedItemHandlerProtocol {
    func getCurrentSelectedIndex(from selectedVideo: SelectedItem?) -> Int?
    func getSelected(with index: Int, completion: @escaping ((SelectedItem)->()))
}

class MovieListBuilder : MovieListBuilderProtocol, SelectedItemHandlerProtocol {
    private var movieList: MovieList
    
    init() {
        self.movieList = MovieList()
    }
    
    func buildOrigin() -> [Video] {
        return self.movieList.origin
    }
    
    private func buildFiltered() -> [Video] {
        return self.movieList.filtered
    }
    
    private func isSearching() -> Bool {
        return self.movieList.isSearching
    }
    
    func getNeedMapList() -> [Video] {
        var results = [Video]()
        let origin = self.buildOrigin()
        let filtered = self.buildFiltered()
        if origin.count > 0 {
            if self.isSearching() == true {
                if filtered.count > 0 && filtered.count < origin.count {
                    results = filtered
                } else if filtered.count == origin.count {
                    results = origin
                }
            } else {
                results = origin
            }
        }
        return results
    }
    
    internal func getCurrentSelectedIndex(from selectedVideo: SelectedItem?) -> Int? {
        if let selected = selectedVideo {
            let currentList = self.getNeedMapList()
            if let selectedIndex = currentList.enumerated()
                .filter({ (index, item) -> Bool in
                    return item.id == selected.id
                }).map({ (index, item) -> Int in
                    return index
                }).first
            {
                return selectedIndex
            }
        }
        return nil
    }
    
    internal func getSelected(with index: Int, completion: @escaping ((SelectedItem)->())) {
        let currentList = self.getNeedMapList()
        if index < currentList.count {
            let selectedVideo = currentList[index]
            Helper.mapSelectedItem(from: selectedVideo) { (selected) in
                completion(selected)
            }
        }
    }
    
    func setOrigin(_ origin: [Video]) {
        self.movieList.origin = origin
    }
    
    func setFiltered(_ filtered: [Video], while searching: Bool) {
        self.movieList.filtered = filtered
        self.movieList.isSearching = searching
    }
}
