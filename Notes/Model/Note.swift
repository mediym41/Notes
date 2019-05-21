//
//  Note.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import CoreData

class Note: NSManagedObjectContext {
    @NSManaged var text: String
    @NSManaged var date: Date
}
