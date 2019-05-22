//
//  DetaliedNoteInsertionState.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import CoreData

class DetaliedNoteInsertionState: DetaliedNoteState {
    private weak var view: DetailedNoteView?
    private var managedObjectContext: NSManagedObjectContext!
    
    init(view: DetailedNoteView, context: NSManagedObjectContext) {
        self.view = view
        self.managedObjectContext = context
    }
    
    // MARK: - DetaliedNoteState protocol
    func viewDidLoad() {
        view?.updateTextViewEditableState(isEnabled: true)
        view?.displayBarButton(title: "title.save")
    }
    
    func rightBarButtonPressed(note: String) {
        guard !note.isEmpty else {
            view?.displayError(title: s("title.note.empty"), message: s("subtitle.note.empty"))
            return
        }
        
        managedObjectContext.performChanges {
            _ = Note.insert(into: self.managedObjectContext, text: note)
        }
        
        view?.dissmiss()
    }
}
