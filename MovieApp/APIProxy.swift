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
        Alamofire.request("https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)", method: .get).responseJSON { response in
            if let result = response.result.value {
                if let JSON = result as? [String:AnyObject] {
                    if let results = JSON["results"] as? [[String:AnyObject]] {
                        var videos:[Video] = []
                        for result in results {
                            var videoBuilder = VideoBuilder()
                            videoBuilder.setId(result["id"] as? Int)
                            videoBuilder.setName(result["original_title"] as? String)
                            videoBuilder.setContent(result["overview"] as? String)
                            videoBuilder.setImgUrl(result["backdrop_path"] as? String)
                            videoBuilder.setPopularity(result["vote_average"] as? Double)
                            videoBuilder.setReleaseDate(result["release_date"] as? String)
                            videoBuilder.setPoster(result["poster_path"] as? String)
                            videos.append(videoBuilder.buildVideo())
                            completion(videos)
                        }
                    }
                }
            }
        }
    }
}
