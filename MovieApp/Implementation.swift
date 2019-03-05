//
//  Implementation.swift
//  MovieApp
//
//  Created by LeeX on 3/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

protocol SelectedItemHandlerProtocol {
    func prepareSelectedIndex(from selectedVideo: SelectedItem?) -> Int?
    func prepareSelectedItem(with index: Int, completion: @escaping ((SelectedItem)->()))
}

protocol MovieListProtocol: SelectedItemHandlerProtocol {
    var origin: [Video] {get set}
    var filtered: [Video] {get set}
    var isSearching: Bool {get set}
    func prepareCurrentList() -> [Video]
}

class MovieList: MovieListProtocol {
    lazy internal var origin: [Video] = {
        return [Video]()
    }()
    lazy internal var filtered: [Video] = {
        return [Video]()
    }()
    lazy internal var isSearching: Bool = {
        return false
    }()
    
    internal func prepareCurrentList() -> [Video] {
        if origin.count > 0 {
            if isSearching == true {
                if filtered.count > 0 && filtered.count < origin.count {
                    return filtered
                } else if filtered.count == origin.count {
                    return origin
                }
            } else {
                return origin
            }
        }
        return []
    }
    
    internal func prepareSelectedIndex(from selectedVideo: SelectedItem?) -> Int? {
        if let selected = selectedVideo {
            let currentList = self.prepareCurrentList()
            if let index = currentList.enumerated()
                .filter({ (index, item) -> Bool in
                    return item.id == selected.id
                }).map({ (index, item) -> Int in
                    return index
                }).first
            {
                return index
            }
        }
        return nil
    }
    
    internal func prepareSelectedItem(with index: Int, completion: @escaping ((SelectedItem)->())) {
        let currentList = self.prepareCurrentList()
        if index < currentList.count {
            let selectedVideo = currentList[index]
            Helper.mapSelectedItem(from: selectedVideo) { (selected) in
                completion(selected)
            }
        }
    }
}
