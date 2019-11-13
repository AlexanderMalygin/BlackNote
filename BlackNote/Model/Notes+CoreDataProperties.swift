//
//  Notes+CoreDataProperties.swift
//  BlackNote
//
//  Created by Alexader Malygin on 22.10.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var note: String?
    @NSManaged public var title: String?

}
