//
//  Notes+CoreDataClass.swift
//  BlackNote
//
//  Created by Alexader Malygin on 22.10.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Notes)
public class Notes: NSManagedObject {

    class func newNote(title: String) -> Notes {
        let note = Notes(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        note.title = title
        
        return note
    }
    
    
    
}
