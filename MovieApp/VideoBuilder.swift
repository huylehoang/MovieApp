//
//  VideoBuilder.swift
//  MovieApp
//
//  Created by LeeX on 1/22/19.
//  Copyright © 2019 LeeX. All rights reserved.
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
    var movieList: MovieList {get set}
    func buildOrigin() -> [Video]
    func buildFiltered() -> [Video]
    func isSearching() -> Bool
    func setFiltered(_ filtered: [Video], while searching: Bool)
    func setOrigin(_ origin: [Video])
    func getNeedMapList() -> [Video]
}

class MovieListBuilder : MovieListBuilderProtocol {
    internal var movieList: MovieList
    
    init() {
        self.movieList = MovieList()
    }
    
    func buildOrigin() -> [Video] {
        return self.movieList.origin
    }
    
    func buildFiltered() -> [Video] {
        return self.movieList.filtered
    }
    
    func isSearching() -> Bool {
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
    
    func setOrigin(_ origin: [Video]) {
        self.movieList.origin = origin
    }
    
    func setFiltered(_ filtered: [Video], while searching: Bool) {
        self.movieList.filtered = filtered
        self.movieList.isSearching = searching
    }
}
