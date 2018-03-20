//
//  adService.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import SwiftyJSON

struct adService {

    static func loadAds() {
        NetworkingProvider.request(router: NetworkingRouter.getAds(), completionHandler: {(data, err) in
            let initQueue = DispatchQueue(label:"create_ad_object", qos: .userInitiated)
            initQueue.async {
                let json = JSON(data!)
                let jsonAdArray = json["items"].arrayValue
                // let ads = adArray.flatMap{Ad($0)}
                var adObjectArray: [Ad] = []


                for ad in jsonAdArray {
                    let location = ad[FinnAPI.adKeys.location].stringValue
                        let score = ad[FinnAPI.adKeys.score].doubleValue

                        let id = ad["id"].intValue

                        let imageURL = ad[FinnAPI.adKeys.image][FinnAPI.adKeys.imageURL].stringValue

                        let adType = ad[FinnAPI.adKeys.adType].stringValue

                        let description = ad[FinnAPI.adKeys.description].stringValue

                        let type = ad[FinnAPI.adKeys.type].stringValue

                        let price = ad[FinnAPI.adKeys.price].intValue


                    let adObject = Ad(location: location, score: score, id: id, imageURL: imageURL, adType: adType, description: description, type: type, price: price)
                    adObjectArray.append(adObject)


                }
                print(adObjectArray)
            }
        })
    }

}
