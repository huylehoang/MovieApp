//
//  MovieListBuilder.swift
//  MovieApp
//
//  Created by LeeX on 2/11/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

protocol MovieListBuilderProtocol {
    var movieList: MovieListProtocol? {get set}
    func setOrigin(_ origin: [Video])
    func setFiltered(_ filtered: [Video], while searching: Bool)
    func getCurrentList() -> [Video]
    func buildOrigin() -> [Video]
}

class MovieListBuilder : MovieListBuilderProtocol {
    internal var movieList: MovieListProtocol?
    
    init(movieList: MovieListProtocol) {
        self.movieList = movieList
    }
    
    func setOrigin(_ origin: [Video]) {
        if self.movieList != nil, origin.count > 0 {
            self.movieList?.origin = origin
        }
    }
    
    func setFiltered(_ filtered: [Video], while searching: Bool) {
        if self.movieList != nil {
            self.movieList?.filtered = filtered
            self.movieList?.isSearching = searching
        }
    }
    
    func getCurrentList() -> [Video] {
        if let list = self.movieList {
            if list.prepareCurrentList().count > 0 {
                return list.prepareCurrentList()
            }
        }
        return []
    }
    
    func buildOrigin() -> [Video] {
        if let list = self.movieList {
            if list.origin.count > 0 {
                return list.origin
            }
        }
        return []
    }
}
