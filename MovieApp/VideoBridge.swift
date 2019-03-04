//
//  VideoBridge.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

struct MovieListBridge {
    static func getMovieListItem(from builder: MovieListBuilderProtocol, completion: (([ListItem])->())) {
        completion(Helper.mapListItem(from: builder.getCurrentList()))
    }
    
    static func getSelectedIndex(from builder: MovieListBuilderProtocol, with selected: SelectedItem?) -> Int? {
        if let list = builder.movieList {
            return list.prepareSelectedIndex(from: selected)
        }
        return nil
    }
    
    static func getSelectedItem(from builder: MovieListBuilderProtocol, with selectedIndex: Int, completion: @escaping ((SelectedItem)->())) {
        if let list = builder.movieList {
            list.prepareSelectedItem(with: selectedIndex) { (selected) in
                completion(selected)
            }
        }
    }
}
