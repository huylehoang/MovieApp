//
//  Video.swift
//  MovieApp
//
//  Created by LeeX on 8/16/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import Foundation
import UIKit

struct Video {
    var id: Int
    var name : String
    var content : String
    var imgURL : String
    var popularity : Int
    var releaseDate: String
    var poster: String
}

struct ListItem {
    var name : String
    var content : String
    var imgURL : String
}

struct SelectedItem {
    var id: Int
    var name: String
    var content: String
    var releaseDate: String
    var popularity: String
    var poster: UIImage
}
