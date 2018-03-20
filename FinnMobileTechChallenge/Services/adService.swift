//
//  adService.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/19/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

struct adService {
    
    typealias ReturnAdsCompletion = (([Ad]) -> Void)
    
    static func loadAds(completion: @escaping ReturnAdsCompletion) -> [Ad] {
        var adObjectArray: [Ad] = []
        
        NetworkingProvider.request(router: NetworkingRouter.getAds(), completionHandler: {(data, err) in
            let initQueue = DispatchQueue(label:"create_ad_object", qos: .userInitiated)
            initQueue.async {
                let json = JSON(data!)
                let jsonAdArray = json["items"].arrayValue
                
                //TODO: Change ad model init to parse data from there
                
                for ad in jsonAdArray {
                    let location = ad[FinnAPI.adKeys.location].stringValue
                    let score = ad[FinnAPI.adKeys.score].doubleValue
                    let id = ad[FinnAPI.adKeys.id].intValue
                    let imageURL = ad[FinnAPI.adKeys.image][FinnAPI.adKeys.imageURL].stringValue
                    let adType = ad[FinnAPI.adKeys.adType].stringValue
                    let description = ad[FinnAPI.adKeys.description].stringValue
                    let type = ad[FinnAPI.adKeys.type].stringValue
                    var price = ad[FinnAPI.adKeys.price][FinnAPI.adKeys.priceValue].stringValue
                    var saved:Bool = false
                    let adObject = Ad(location: location, score: score, id: id, imageURL: imageURL, adType: adType, description: description, type: type, price: price, saved:saved)
                    
                    adObjectArray.append(adObject)
                }
                DispatchQueue.main.async {
                    completion(adObjectArray)
                }
            }
        })
        return adObjectArray
    }
    
    //TODO: - Add Function that loads all ads from CoreData w/completion
    //TODO: - Add Function that deletes a specific ad from Core Data
    
    // If a price is present, the type of currency should be added to it
    static func priceChecker(string:String) -> String {
        if string != "" {
            var newPrice = string + " kr"
            return newPrice
        } else {
            return string
        }
    }
    
    //This function makes it quick to create a URL for requests to generate images.
    static func imageURLConverter(imageUrlPath:String) -> URL {
        let baseURL = FinnAPI.imageBaseURL
        let imageUrlString = baseURL + imageUrlPath
        let imageURL = URL(string:imageUrlString)
        return imageURL!
    }
    
    static func saveAd(ad:Ad, image:UIImage) {
        let coreData = CoreData()
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        var advertisement:NSManagedObject?
        advertisement?.setValue(ad.location, forKey: "location")
        advertisement?.setValue(ad.score, forKey: "score")
        advertisement?.setValue(ad.id, forKey: "id")
        advertisement?.setValue(imageData, forKey: "imageData")
        advertisement?.setValue(ad.adType, forKey: "adType")
        advertisement?.setValue(ad.description, forKey: "type")
        advertisement?.setValue(ad.price, forKey: "price")
        
        coreData.saveContext()
    }
}



