//
//  SavedAd.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/21/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
class SavedAd {
    var location:String
    var score:Double
    var id:Int
    var imageData:NSData
    var adType:String
    var description:String
    var type:String
    
    //Since purchases won't be made in the case of this app, it is best to keep it as a String since making it an int or double would return a zero instead of a blank in the collectionView
    var price:String
    var saved:Bool
    init(location:String, score:Double, id:Int, imageData:NSData,adType:String, description:String, type:String, price:String, saved:Bool ) {
        //TODO: update init so that json parses when initiated
        //TODO: update model so that it keeps track of if the object has been saved or not
        self.location = location
        self.score = score
        self.id = id
        self.imageData = imageData
        self.adType = adType
        self.description = description
        self.type = type
        self.price = price
        self.saved = saved
    }
}
