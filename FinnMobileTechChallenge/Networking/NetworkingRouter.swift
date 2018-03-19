//
//  NetworkingRouter.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkingRouter: RouterProtocol {

    case getAds()
    case getImages(path:URL)

    public var baseURL: URL {
        switch self {
        case .getAds:
            return FinnAPI.getAds
        case .getImages(let path):
            return FinnAPI.getImages 

        }
    }

    var headers: [String:String]? {
        switch self {
        case .getImages, .getAds:
            return ["Content-type": "application/json"]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getImages, .getAds:
            return .get
        }
    }


}
