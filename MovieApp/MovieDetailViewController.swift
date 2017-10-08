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
    @IBOutlet weak var dragView: UIView!
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
        
        let videoContentHeight = videoContent.optimalHeight
        videoContent.frame = CGRect(x: videoContent.frame.origin.x, y: videoContent.frame.origin.y, width: videoContent.frame.width, height: videoContentHeight)
        videoContent.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func viewWasDragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: dragView)
        
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: { 
                self.dragView.frame.origin = CGPoint(x: 33, y: 408)
            })
        }
    }

}
