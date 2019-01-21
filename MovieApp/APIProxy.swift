//
//  APIProxy.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import Alamofire

struct FetchMovieProxy {
    public func fetchDataMovie(with endpoint: String, completion: @escaping (([Video]) ->())) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let mainImageUrl = "http://image.tmdb.org/t/p/w500"
        Alamofire.request("https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)", method: .get).responseJSON { response in
            if let result = response.result.value {
                if let JSON = result as? [String:AnyObject] {
                    if let results = JSON["results"] as? [[String:AnyObject]] {
                        var videos:[Video] = []
                        for result in results {
                            if let id = result["id"] as? Int
                                , let name = result["original_title"] as? String
                                , let content = result["overview"] as? String
                                , let backdropPath = result["backdrop_path"] as? String
                                , let popularity = result["vote_average"] as? Float
                                , let releaseDate = result["release_date"] as? String
                                , let posterPath = result["poster_path"] as? String
                            {
                                let imgURL = mainImageUrl + backdropPath
                                let poster = mainImageUrl + posterPath
                                let popularityNum = Int(popularity * 10)
                                videos.append(Video(id: id, name: name, content: content, imgURL: imgURL, popularity: popularityNum, releaseDate: releaseDate, poster: poster))
                            }
                            completion(videos)
                        }
                    }
                }
            }
        }
    }
}
