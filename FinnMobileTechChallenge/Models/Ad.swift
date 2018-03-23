//
//  Ad.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Ad {
    var location:String
    var score:Double
    var id:Int
    var imageURL:String
    var adType:String
    var description:String
    var type:String
    var imageData:NSData?

    //Since purchases won't be made in the case of this app, it is
    //best to keep it as a String since making it an int or double
    //would return a zero instead of a blank in the collectionView
    var price:String
    var saved:Bool

    init(location:String,
         score:Double,
         id:Int,
         imageURL:String,
         adType:String,
         description:String,
         type:String,
         price:String,
         saved:Bool,
         imageData:NSData?) {

        self.location = location
        self.score = score
        self.id = id
        self.imageURL = imageURL
        self.adType = adType
        self.description = description
        self.type = type
        self.price = price
        self.saved = saved
        self.imageData = imageData

    }

}
