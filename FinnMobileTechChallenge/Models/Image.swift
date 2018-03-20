//
//  Image.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Image {

    var scalable:Bool
    var width:Int
    var type:String
    var url:String
    var height:Int

    init(scalable:Bool, width:Int, type:String, url:String, height:Int){
        self.scalable = scalable
        self.width = width
        self.type = type
        self.url = url
        self.height = height 
    }
}
