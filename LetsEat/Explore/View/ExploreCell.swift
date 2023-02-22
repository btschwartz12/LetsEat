//
//  ExploreCell.swift
//  LetsEat
//
//  Created by Ben Schwartz on 3/21/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
   
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgExplore: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCorners()
    }
    
}

private extension ExploreCell {
    func roundedCorners() {
        imgExplore.layer.cornerRadius = 9
        imgExplore.layer.masksToBounds = true
    }
}
