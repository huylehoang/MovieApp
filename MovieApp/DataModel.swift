//
//  DataModel.swift
//  MovieApp
//
//  Created by LeeX on 7/24/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import Foundation
import UIKit
//import AFNetworking
import Alamofire

protocol Delegate: class {
    func didReceiveData(data: [Video])
}

class DataModel{
    
    var delegate: Delegate?
    
    var endpoint:String = ""
    
//    func fetchDataMovie() {
//
//        var videos:[Video] = []
//
//        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
//        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
//        let request = URLRequest(
//            url: url!,
//            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
//            timeoutInterval: 10)
//        let session = URLSession(
//            configuration: URLSessionConfiguration.default,
//            delegate: nil,
//            delegateQueue: OperationQueue.main
//        )
//        let task: URLSessionDataTask =
//            session.dataTask(with: request,
//                             completionHandler: { (dataOrNil, response, error) in
//                                if let data = dataOrNil {
//
//                                    if let responseDictionary = try! JSONSerialization.jsonObject(
//                                        with: data, options:JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] {
//
//                                        if (responseDictionary["results"] as? [[String:AnyObject]]) != nil {
//                                            let results = responseDictionary["results"] as? [[String:AnyObject]]
//                                            print(results!)
//
//                                            var newVideos = [Video]()
//
//                                            for result in results! {
//
//                                                let name = result["original_title"]! as! String
//                                                let content = result["overview"]! as! String
//                                                let imgURL = "http://image.tmdb.org/t/p/w500" + "\(result["backdrop_path"]!)"
//                                                let popularity = result["popularity"]! as! Float
//                                                let releaseDate = result["release_date"]! as! String
//
//                                                newVideos.append(Video(name: name, content: content, imgURL: imgURL, popularity: popularity, releaseDate: releaseDate))
//                                            }
//
//                                            videos = newVideos
//
//                                            self.delegate?.didReceiveData(data: videos)
//
//                                        }
//                                    }
//                                }
//            })
//        task.resume()
//    }
    
    func fetchDataMovie() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let parameters: Parameters = ["foo": "bar"]
        Alamofire.request("https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)", method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let result = response.result.value {
                if let JSON = result as? [String:AnyObject] {
                    if let results = JSON["results"] as? [[String:AnyObject]] {
                        
                        var videos:[Video] = []
                        
                        for result  in results {
                            let name = result["original_title"]! as! String
                            let content = result["overview"]! as! String
                            let imgURL = "http://image.tmdb.org/t/p/w500" + "\(result["backdrop_path"]!)"
                            
                            let popularity = result["popularity"]! as! Float
                            let releaseDate = result["release_date"]! as! String
                            
                            videos.append(Video(name: name, content: content, imgURL: imgURL, popularity: popularity, releaseDate: releaseDate))
                        }
                        self.delegate?.didReceiveData(data: videos)
                    }
                }
            }
        }
    }
}

