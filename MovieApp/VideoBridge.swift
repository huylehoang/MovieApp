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
    
    static func getSelectedIndex(from list: MovieListBuilder, with selected: SelectedItem?) -> Int? {
        return list.getCurrentSelectedIndex(from: selected)
    }
    
    static func getSelectedItem(from list: MovieListBuilder, with selectedIndex: Int, completion: @escaping ((SelectedItem)->())) {
        list.getSelected(with: selectedIndex) { (selected) in
            completion(selected)
        }
    }
}
