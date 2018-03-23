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
import AlamofireImage
import Alamofire

struct adService {
    
    typealias ReturnAdsCompletion = (([Ad]) -> Void)
    typealias ReturnImageCompletion = ((UIImage) -> Void)
    
    static func loadAds(completion: @escaping ReturnAdsCompletion) -> [Ad] {
        var adObjectArray: [Ad] = []
        
        NetworkingProvider.request(router: NetworkingRouter.getAds(), completionHandler: {(data, err) in
            let initQueue = DispatchQueue(label:"create_ad_object", qos: .userInitiated)
            initQueue.async {
                let json = JSON(data!)
                let jsonAdArray = json["items"].arrayValue
                
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
                    var imageData:NSData? = nil
                    let adObject = Ad(location: location, score: score, id: id, imageURL: imageURL, adType: adType, description: description, type: type, price: price, saved:saved, imageData:imageData)
                    
                    adObjectArray.append(adObject)
                }
                DispatchQueue.main.async {
                    completion(adObjectArray)
                }
            }
        })
        return adObjectArray
    }
    
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
    static func saveButtonToggle(saved:Bool) -> UIImage {
        var image = UIImage()
        if saved == true {
            image = UIImage(named:"redHeart.png")!
            return image
        }
        else {
            image = UIImage(named:"whiteHeart.png")!
            return image
        }
    }
    static func toggleSave(ad:Ad) -> Bool {
        var result = Bool()
        if ad.saved == true {
            CoreData.deleteAd(title: ad.description)
            result = false
            return result
        }
        else {
            CoreData.saveAd(ad: ad)
            result = true
            return result
        }
    }

    static func downloadAdImage(ad:Ad, imageUrlString:String, completion: @escaping ReturnImageCompletion) {
        let url = adService.imageURLConverter(imageUrlPath: ad.imageURL)
        Alamofire.request(url).responseImage { response in

            if let image = response.result.value {
                completion(image)
            }

        }
    }
    


    static func unSavedAdSeperator(ads:[Ad])-> [Ad] {
        var result:[Ad] = []

        for ad in ads {
            let isSaved = ad.saved

            if isSaved == false {
                let seperatedAd = ad
                result.append(seperatedAd)

            }
            

        }
        return result

    }


    static func adChecker(ads:[Ad], titles:[String]) {
        for ad in ads {
            let adTitle = ad.description
            for title in titles {
                if title == adTitle {
                    ad.saved = true
                }
            }

        }

    }


}



