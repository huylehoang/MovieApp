//
//  VideoBridge.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

struct MovieListBridge {
    static func getMovieListItem(from list: MovieListBuilder, completion: (([ListItem])->())) {
        completion(Helper.mapListItem(from: list.getNeedMapList()))
    }
}
