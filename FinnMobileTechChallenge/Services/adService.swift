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
    static func isSavedButtonToogle(saved:Bool) -> UIImage {
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
    static func toggleSave(saved:Bool, ad:Ad, index:Int) -> Bool {
        var result = Bool()
        if saved == true {
            adService.deleteAd(index: index)
            result = false
            return result
        }
        else {
            adService.saveAd(ad: ad)
            result = true
            return result
        }
    }
    static func savedAdImageToggle(image:UIImage) -> UIImage {
        if  image == UIImage(named:"whiteHeart.png") {
            // adService.saveAd(ad: <#T##Ad#>, image: <#T##UIImage#>)
            let newImage = UIImage(named:"redHeart.png")
            return newImage!

        }
        else if image == UIImage(named:"whiteHeart.png") {
            //adService.deleteAd(ad: Ad)
            let newImage = UIImage(named:"redHeart.png")
            return newImage!
        }
        return image
    }
    static func downloadAdImage(ad:Ad, imageUrlString:String, completion: @escaping ReturnImageCompletion) {
        let url = adService.imageURLConverter(imageUrlPath: ad.imageURL)
        Alamofire.request(url).responseImage { response in

            if let image = response.result.value {
                completion(image)
            }

        }
    }
    
    static func saveAd(ad:Ad) {
        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        adService.downloadAdImage(ad: ad, imageUrlString: (FinnAPI.imageBaseURL + ad.imageURL), completion: {image in

            let entity = NSEntityDescription.entity(forEntityName: "Advertisement", in: (context))
            let advertisement = NSManagedObject(entity: entity!, insertInto: context)

        
        let imageData = UIImageJPEGRepresentation(image, 1) as! NSData
            print(type(of: imageData))


        advertisement.setValue(ad.location, forKey: "location")
        advertisement.setValue(ad.score, forKey: "score")
        advertisement.setValue(ad.id, forKey: "id")
        advertisement.setValue(imageData, forKey: "imagesData")
        advertisement.setValue(ad.adType, forKey: "type")
        advertisement.setValue(ad.description, forKey: "title")
        advertisement.setValue(ad.price, forKey: "price")
        
        coreData.saveContext()
            })
    }
    static func deleteAd(index:Int) {

        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        let request:NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
        do {
            var results = try context.fetch(request)
            let item = results.remove(at: index)
            context.delete(item)
            do {
                try context.save()
            } catch {
                print("Error saving context")
            }

        }
        catch {
            fatalError()
        }
    }
    static func clearAds() {
        let coreData = CoreData()
        let entity = "Advertisement"
        let context = coreData.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }

    }
    static func loadKeys() -> [SavedAd]{

        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        let request:NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
        var adsArray = [SavedAd]()


        do {
            var results = try context.fetch(request)
            for result in results {
                let title = result.title!
                let id = result.id
                let imageData = result.imagesData!
                let type = result.type!
                let location = result.location!
                let score = result.score
                let price = result.price!
                let saved = true

                let savedAd = SavedAd(location: location, score: score, id: Int(id), imageData: imageData as NSData, adType: type, description: title, type: type, price: price, saved: saved)
                adsArray.append(savedAd)

            }

            
        }
        catch {
            fatalError()
        }
        return adsArray
    }
    static func viewCoreData() {

        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        let request:NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
        do {
            var results = try context.fetch(request)
            print(results)
        }
        catch {
            fatalError()
        }
    }
}



