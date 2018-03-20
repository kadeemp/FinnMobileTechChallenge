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
    //TODO: Double check if this is the correct format
    var imageURL:String
    var adType:String
    var description:String
    var type:String
    //TODO: Double check if this should be a Double
    var price:Int

    init(location:String, score:Double, id:Int, imageURL:String,adType:String, description:String, type:String, price:Int ) {
//        guard let location = json[FinnAPI.adKeys.location].string,
//            let score = json[FinnAPI.adKeys.score].double,
//            let id = json[FinnAPI.adKeys.id].int,
//            let imageURL = json[FinnAPI.adKeys.image][FinnAPI.adKeys.imageURL].string,
//            let adType = json[FinnAPI.adKeys.adType].string,
//            let description = json[FinnAPI.adKeys.description].string,
//            let type = json[FinnAPI.adKeys.type].string,
//            let price = json[FinnAPI.adKeys.price].int
//            else { return nil }

        self.location = location
        self.score = score
        self.id = id
        self.imageURL = imageURL
        self.adType = adType
        self.description = description
        self.type = type
        self.price = price

    }

}
