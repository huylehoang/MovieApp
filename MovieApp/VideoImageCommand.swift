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
    func execute(imgUrl: String, completion: ((UIImage)->())?)
}

struct GetImageCommand: VideoImageCommand {
    func execute(imgUrl: String, completion: ((UIImage) -> ())?) {
        Alamofire.request(imgUrl).responseImage { response in
            if let image = response.result.value {
                completion?(image)
            }
        }
    }
}
