//
//  PhotoCell.swift
//  LetsEat
//
//  Created by Ben Schwartz on 4/24/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imgReview: UIImageView!
    
}

extension PhotoCell {
    func set(image:UIImage) {
        imgReview.image = image
        roundedCorners()
    }
    
    func roundedCorners() {
        imgReview.layer.cornerRadius = 9
        imgReview.layer.masksToBounds = true
    }
}
