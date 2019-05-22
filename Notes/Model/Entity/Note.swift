//
//  Note.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import CoreData

class Note: NSManagedObject, Managed  {
    @NSManaged var text: String
    @NSManaged var date: Date
    
    static func insert(into context: NSManagedObjectContext, text: String) -> Note {
        let note: Note = context.insertObject()
        note.text = text
        note.date = Date()
        
        return note
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(Note.date), ascending: false)]
    }
}
