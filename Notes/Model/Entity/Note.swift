//
//  Note.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import CoreData

class Note: NSManagedObject, Managed  {
    public static let normalizedTextKey = "text_normalized"
    
    @NSManaged var date: Date
    @NSManaged var textPrimitive: String
    
    @objc public var text: String {
        set {
            willChangeValue(forKey: #keyPath(text))
            textPrimitive = newValue
            updateNormalizedText(newValue)
            didChangeValue(forKey: #keyPath(text))
        }
        get {
            willAccessValue(forKey: #keyPath(text))
            let value = textPrimitive
            didAccessValue(forKey: #keyPath(text))
            
            return value
        }
    }
    
    // Search optimization
    fileprivate func updateNormalizedText(_ text: String) {
        setValue(text.normalizedForSearch, forKey: Note.normalizedTextKey)
    }
    
    static func insert(into context: NSManagedObjectContext, text: String) -> Note {
        let note: Note = context.insertObject()
        note.date = Date()
        note.text = text
        
        return note
    }
    
    // MARK: - Managed protocol
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(Note.date), ascending: false)]
    }
}
