//
//  VideoBridge.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

protocol MovieProtocol {
    var origin: [Video] {get set}
    var filtered: [Video] {get set}
    init(origin: [Video], filtered: [Video])
    func getNeedMapList(while isSearching: Bool) -> [Video]
}

class MovieList: MovieProtocol {
    var origin: [Video]
    var filtered: [Video]
    
    required init(origin: [Video], filtered: [Video]) {
        self.origin = origin
        self.filtered = filtered
    }
    
    func getNeedMapList(while isSearching: Bool) -> [Video] {
        var results = [Video]()
        if origin.count > 0 {
            if isSearching == true {
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
}

struct MovieListBridge {
    static func getMovieListItem(from list: MovieList, while searching: Bool, completion: (([ListItem])->())) {
        completion(Helper.mapListItem(from: list.getNeedMapList(while: searching)))
    }
}
