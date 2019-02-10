//
//  VideoBuilder.swift
//  MovieApp
//
//  Created by LeeX on 1/22/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation

protocol VideoProtocol {
    var id: Int {get set}
    var name : String {get set}
    var content : String {get set}
    var imgURL : String {get set}
    var popularity : Int {get set}
    var releaseDate: String {get set}
    var poster: String {get set}
}

struct VideoBuilder: VideoProtocol {
    var id: Int = 0
    var name : String = ""
    var content : String = ""
    var imgURL : String = ""
    var popularity : Int = 0
    var releaseDate: String = ""
    var poster: String = ""
    
    lazy private var mainImageURL : String = {
        return "http://image.tmdb.org/t/p/w500"
    }()
    
    mutating func setId(_ newId: Int?) {
        if let newId = newId {
            self.id = newId
        }
    }
    
    mutating func setName(_ newName: String?) {
        if let newName = newName {
            self.name = newName
        }
    }
    mutating func setContent(_ newContent: String?) {
        if let newContent = newContent {
            self.content = newContent
        }
    }
    mutating func setImgUrl(_ newImgUrl: String?) {
        if let newImgUrl = newImgUrl {
            self.imgURL = self.mainImageURL + newImgUrl
        }
    }
    mutating func setPopularity(_ newPopularity: Double?) {
        if let newPopularity = newPopularity {
            self.popularity = Int(newPopularity * 10)
        }
    }
    
    mutating func setReleaseDate(_ newReleaseDate: String?) {
        if let newReleaseDate = newReleaseDate {
            self.releaseDate = newReleaseDate
        }
    }
    
    mutating func setPoster(_ newPoster: String?) {
        if let newPoster = newPoster {
            self.poster = self.mainImageURL + newPoster
        }
    }
    
    func buildVideo() -> Video {
        return Video(id: self.id, name: self.name, content: self.content, imgURL: self.imgURL, popularity: self.popularity, releaseDate: self.releaseDate, poster: self.poster)
    }
    
}
