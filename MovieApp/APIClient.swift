//
//  APIClient.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    private let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    private let mainImageUrl = "http://image.tmdb.org/t/p/w500"
    private static var sharedApiClient: ApiClient = {
        return ApiClient()
    }()
    class func shared() -> ApiClient {
        return sharedApiClient
    }
    
    func fetchDataMovie(with endpoint: String, completion: (([Video]) ->())?) {
        Alamofire.request("https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)", method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
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
                                let imgURL = strongSelf.mainImageUrl + backdropPath
                                let poster = strongSelf.mainImageUrl + posterPath
                                let popularityNum = Int(popularity * 10)
                                videos.append(Video(id: id, name: name, content: content, imgURL: imgURL, popularity: popularityNum, releaseDate: releaseDate, poster: poster))
                            }
                            completion?(videos)
                        }
                    }
                }
            }
        }
    }
}
