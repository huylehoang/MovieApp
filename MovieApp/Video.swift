//
//  Video.swift
//  MovieApp
//
//  Created by LeeX on 8/16/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import Foundation

struct Video {
    var name : String!
    var content : String!
    var imgURL : String!
    var popularity : Int!
    var releaseDate: String!
    
    init(name: String, content: String, imgURL: String, popularity: Int, releaseDate: String) {
        self.name = name
        self.content = content
        self.imgURL = imgURL
        self.popularity = popularity
        self.releaseDate = releaseDate
    }
}
