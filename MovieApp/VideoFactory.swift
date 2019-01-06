//
//  VideoFactory.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

class VideoFactory {
    static func getMovieListItem(from origin: [Video], and filtered: [Video], while isSearching: Bool, completion: (([ListItem])->())?) {
        if origin.count > 0 {
            if isSearching == true {
                if filtered.count > 0 && filtered.count < origin.count {
                    completion?(Helper.mapListItem(from: filtered))
                } else if filtered.count == origin.count {
                    completion?(Helper.mapListItem(from: origin))
                } else if filtered.count == 0 {
                    completion?([])
                }
            } else {
                completion?(Helper.mapListItem(from: origin))
            }
        } else {
            completion?([])
        }
    }
}
