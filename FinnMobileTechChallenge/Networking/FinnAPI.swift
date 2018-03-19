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

    static var imagesBaseURLComponent: URLComponents {
        var baseUrl = URLComponents()
        baseUrl.scheme = "https"
        baseUrl.host = "images.finncdn.no"
        baseUrl.path = "/dynamic/default/"
        return baseUrl
    }

    static var adsBaseURLComponent: URLComponents {
        var baseUrl = URLComponents()
        baseUrl.scheme = "https"
        baseUrl.host = "gist.githubusercontent.com"
        baseUrl.path = "3lvis/3799feea005ed49942dcb56386ecec2b/raw/63249144485884d279d55f4f3907e37098f55c74/discover.json"
        return baseUrl
    }

    static var imagesURL = "https://images.finncdn.no/dynamic/default"
    static var adsURL = "https://gist.githubusercontent.com/3lvis/3799feea005ed49942dcb56386ecec2b/raw/63249144485884d279d55f4f3907e37098f55c74/discover.json"


    static var getAds: URL {
        let adURL = URL(string: adsURL)
        do {
            return try adURL!.asURL()
        } catch {
            fatalError("Error creating Ad JSON URL")
        }
    }

    static var getImages: URL {
        let imageURL = URL(string:imagesURL)
        do {
            return try imagesURL.asURL()
        } catch {
            fatalError("Error creating Ad JSON URL")
        }
    }
}

