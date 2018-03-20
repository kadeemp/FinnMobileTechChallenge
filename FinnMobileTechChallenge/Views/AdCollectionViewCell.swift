//
//  AdCollectionViewCell.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    //Need access to the object being edited so that other cells arent affected. The redHeart gets reused when it isn't supposed to.

    @IBAction func saveAdPressed(_ sender:UIButton) {

        let currentImage = saveButton.currentImage
        if  currentImage == UIImage(named:"whiteHeart.png") {
            // adService.saveAd(ad: <#T##Ad#>, image: <#T##UIImage#>)
            sender.setImage(UIImage(named:"redHeart.png"), for: .normal)
        }
        else {
            //adService.deleteAd(ad: Ad)
            sender.setImage(UIImage(named:"whiteHeart.png"), for: .normal)
        }

    }
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var adDescription: UILabel!
    @IBOutlet weak var adLocation: UILabel!
    @IBOutlet weak var adPrice: UILabel!
}
