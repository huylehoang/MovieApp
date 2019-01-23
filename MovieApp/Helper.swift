//
//  Helper.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit
class Helper {
    static func mapListItem(from videos: [Video]) -> [ListItem] {
        return videos.map({ (video) -> ListItem in
            return ListItem(name: video.name, content: video.content, imgURL: video.imgURL)
        })
    }
    
    static func mapSelectedItem(from selectedVideo: Video, completion: @escaping ((SelectedItem)->())) {
        GetImageCommand.execute(imgUrl: selectedVideo.poster) { (posterImage) in
            let popularity = String(describing: selectedVideo.popularity)
            let selected = SelectedItem(name: selectedVideo.name, content: selectedVideo.content, releaseDate: selectedVideo.releaseDate, popularity: popularity, poster: posterImage)
            completion(selected)
        }
    }
}
