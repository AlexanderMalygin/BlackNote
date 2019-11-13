//
//  CoreDataManager.swift
//  BlackNote
//
//  Created by Alexader Malygin on 23.10.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import UIKit
import CoreData

var notes: [Notes] {
    
    let request = NSFetchRequest<Notes>(entityName: "Notes")
    
    let sortDescr = NSSortDescriptor(key: "title", ascending: true)
    request.sortDescriptors = [sortDescr]
    
    
    let array = try? CoreDataManager.sharedInstance.managedObjectContext.fetch(request)
    
    if array != nil {
        return array!
    }

    return []
}




class CoreDataManager {
    // MARK: - Core Data stack
    static let sharedInstance = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "BlackNote")
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
