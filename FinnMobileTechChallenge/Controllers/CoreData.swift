//
//  CoreData.swift
//  FinnMobileTechChallenge
//
//  Created by Kadeem Palacios on 3/20/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import CoreData

class CoreData {

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

}
