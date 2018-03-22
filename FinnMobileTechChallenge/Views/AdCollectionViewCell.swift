//
//  AdCollectionViewCell.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    
    @IBAction func saveAdPressed(_ sender:UIButton) {
        
    }
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var adDescription: UILabel!
    @IBOutlet weak var adLocation: UILabel!
    @IBOutlet weak var adPrice: UILabel!
}
