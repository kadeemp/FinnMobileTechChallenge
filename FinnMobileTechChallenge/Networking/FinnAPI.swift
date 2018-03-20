//
//  FinnAPI.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import Alamofire

struct FinnAPI {

    static var imageBaseURL = "https://images.finncdn.no/dynamic/default/"

    static var adsURL = "https://gist.githubusercontent.com/3lvis/3799feea005ed49942dcb56386ecec2b/raw/63249144485884d279d55f4f3907e37098f55c74/discover.json"


    static var getAds: URL {
        let adURL = URL(string: adsURL)
        do {
            return try adURL!.asURL()
        } catch {
            fatalError("Error creating Ad JSON URL")
        }
    }
    //TODO: Adjust so that adservice doesn't have to create its own URL

    static var getImages: URL {
        let imageURL = URL(string:imageBaseURL)
        do {
            return try imageBaseURL.asURL()
        } catch {
            fatalError("Error creating image JSON URL")
        }
    }
    
    struct adKeys{
        static let location = "location"
        static let score = "score"
        static let id = "id"
        static let image = "image"
        static let adType = "adType"
        static let description = "description"
        static let type = "type"
        static let price = "price"
        static let priceValue = "value"
        static let imageURL = "url"

    }
}

