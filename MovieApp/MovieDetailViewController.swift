//
//  SecondViewController.swift
//  MovieApp
//
//  Created by LeeX on 8/23/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var videoContent: UILabel!
    @IBOutlet weak var videoPopularity: UILabel!
    @IBOutlet weak var videoReleaseDate: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popularity = video.popularity
        let popularityString = String(describing: popularity!)

        
        videoTitle.text = video.name
        videoContent.text = video.content
        videoReleaseDate.text = video.releaseDate
        videoPopularity.text = popularityString + "%"
        let imgURL = NSURL(string: video.imgURL)
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            videoImage.image = UIImage(data: data as! Data)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
