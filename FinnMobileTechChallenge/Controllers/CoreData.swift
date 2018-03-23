//
//  CoreData.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/20/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import CoreData
import AlamofireImage

class CoreData {
    
    //TODO: Create function to find Ads based on different predicates
    
    // MARK: - Core Data container setup
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AdCoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    static func saveAd(ad:Ad) {
        let coreData = CoreData()
        
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        adService.downloadAdImage(ad: ad, imageUrlString: (FinnAPI.imageBaseURL + ad.imageURL), completion: {image in
            
            let entity = NSEntityDescription.entity(forEntityName: "Advertisement", in: (context))
            let advertisement = NSManagedObject(entity: entity!, insertInto: context)
            let imageData = UIImageJPEGRepresentation(image, 1)! as NSData
            
            advertisement.setValue(ad.location, forKey: "location")
            advertisement.setValue(ad.score, forKey: "score")
            advertisement.setValue(ad.id, forKey: "id")
            advertisement.setValue(imageData, forKey: "imageData")
            advertisement.setValue(ad.adType, forKey: "type")
            advertisement.setValue(ad.description, forKey: "title")
            advertisement.setValue(ad.price, forKey: "price")
            advertisement.setValue(ad.imageURL, forKey: "imageURL")
            advertisement.setValue(true, forKey: "savedState")
            
            coreData.saveContext()
        })
    }
    
    // MARK: - Core Data Deletion Support
    
    static func deleteAd(title:String) {
        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        do {
            let request:NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@", title)
            let fetchedResults = try context.fetch(request)
            let result = fetchedResults.first
            
            context.delete(result!)
            try context.save()
        }
        catch {
            print("Error fetching ad")
        }
    }
    static func clearAds() {
        let coreData = CoreData()
        let entity = "Advertisement"
        let context = coreData.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch {
            print ("There was an error")
        }
    }
    // MARK: - Core Data Loading Support
    static func loadAds() -> [Ad]{
        
        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        let request:NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
        var adsArray = [Ad]()
        
        do {
            let results = try context.fetch(request)
            for result in results {
                let title = result.title!
                let id = result.id
                let imageData = result.imageData! as NSData
                let type = result.type!
                let location = result.location!
                let score = result.score
                let price = result.price!
                let saved = result.savedState
                let imageURL = result.imageURL
                
                let newAd = Ad(location: location,
                               score: score,
                               id: Int(id),
                               imageURL:(imageURL)!,
                               adType: type,
                               description: title,
                               type: type,
                               price: price,
                               saved: saved,
                               imageData: imageData)
                adsArray.append(newAd)
            }
            
            
        }
        catch {
            fatalError()
        }
        return adsArray
    }
    //The titles from this function will be used to compare against json data so i know saved ads vs unsaved ads
    static func loadAdTitles() -> [String] {
        
        let coreData = CoreData()
        let context:NSManagedObjectContext = coreData.persistentContainer.viewContext
        let request:NSFetchRequest<Advertisement> = Advertisement.fetchRequest()
        var adTitles:[String] = []
        do {
            let results = try context.fetch(request)
            
            for result in results {
                let title = result.title!
                adTitles.append(title)
            }
            return adTitles
        }
        catch {
            fatalError()
        }
        return adTitles
    }
}
