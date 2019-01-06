//
//  FilterCommand.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

protocol FilterCommand {
    var videos: [Video] {get set}
    func execute(with filter: String) -> [Video]
}

struct FilterVideoCommand: FilterCommand {
    var videos: [Video]
    func execute(with filter: String) -> [Video] {
        if filter != "" {
            let filtered = videos.filter { (video) -> Bool in
                return video.name.lowercased().contains(filter.lowercased())
            }
            if filtered.count > 0 {
                return filtered
            } else {
                return []
            }
        } else {
            return videos
        }
    }
}
