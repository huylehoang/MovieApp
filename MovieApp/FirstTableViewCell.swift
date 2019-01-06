//
//  FirstTableViewCell.swift
//  MovieApp
//
//  Created by LeeX on 7/8/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var videoContent: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoThumnailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func binding(title: String, content: String, thumbnailUrl: String) {
        self.videoTitle.text = title
        self.videoContent.text = content
        let getImageContent = GetImageCommand()
        getImageContent.execute(imgUrl: thumbnailUrl) { [weak self] (image) in
            guard let strongSelf = self else { return }
            strongSelf.videoThumnailImageView.image = image
        }
    }
}
