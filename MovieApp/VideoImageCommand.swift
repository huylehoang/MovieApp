//
//  VideoImageCommand.swift
//  MovieApp
//
//  Created by LeeX on 1/5/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol VideoImageCommand {
    static func execute(imgUrl: String, completion: @escaping ((UIImage)->()))
}

struct GetImageCommand: VideoImageCommand {
    static func execute(imgUrl: String, completion: @escaping ((UIImage) -> ())) {
        Alamofire.request(imgUrl).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
}
