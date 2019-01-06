//
//  SecondViewController.swift
//  MovieApp
//
//  Created by LeeX on 8/23/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {

    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var videoContent: UILabel!
    @IBOutlet weak var videoPopularity: UILabel!
    @IBOutlet weak var videoReleaseDate: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var video: SelectedItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let video = self.video {
            videoTitle.text = video.name
            videoContent.text = video.content
            videoReleaseDate.text = video.releaseDate
            videoPopularity.text = video.popularity + "%"
            videoImage.image = video.poster
        }
    }
}
