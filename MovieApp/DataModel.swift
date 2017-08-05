//
//  DataModel.swift
//  MovieApp
//
//  Created by LeeX on 7/24/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

protocol Delegate: class {
    func didReceiveDataNames(dataNames: [String])
    func didReceiveDataContens(dataContents: [String])
    func didReceiveDataImages(dataImages: [String])
}

class DataModel {
    
    var delegate: Delegate?
    
    func fetchDataMovie() {
        
        var names:[String] = []
        
        var contents:[String] = []
        
        var images:[String] = []
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(
            url: url!,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        let task: URLSessionDataTask =
            session.dataTask(with: request,
                             completionHandler: { (dataOrNil, response, error) in
                                if let data = dataOrNil {
                                    
                                    if let responseDictionary = try! JSONSerialization.jsonObject(
                                        with: data, options:JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] {
                                       
                                        if (responseDictionary["results"] as? [[String:AnyObject]]) != nil {
                                            let results = responseDictionary["results"] as? [[String:AnyObject]]
                                            var newNames:[String] = []
                                            var newContents:[String] = []
                                            var newImages:[String] = []

                                            for result in results! {
                                                newNames.append(result["original_title"]! as! String)
                                                newContents.append(result["overview"]! as! String)
                                                newImages.append("http://image.tmdb.org/t/p/w500" + "\(result["backdrop_path"]!)")
                                            }
                                            names = newNames
                                            contents = newContents
                                            images = newImages
                                            
                                            self.delegate?.didReceiveDataNames(dataNames: names)
                                            self.delegate?.didReceiveDataContens(dataContents: contents)
                                            self.delegate?.didReceiveDataImages(dataImages: images)
                                        }
                                    }
                                }
            })
        task.resume()
    }
}
