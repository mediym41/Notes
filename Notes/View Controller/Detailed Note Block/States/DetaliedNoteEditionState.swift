//
//  DetaliedNoteEditionState.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

class DetaliedNoteEditionState: DetaliedNoteState {
    private weak var view: DetailedNoteView?
    var isEditing = false
    
    init(view: DetailedNoteView) {
        self.view = view
    }
    
    // MARK: - DetaliedNoteState protocol
    func viewDidLoad() {
        view?.updateTextViewEditableState(isEnabled: false)
        view?.displayBarButton(title: "title.edit")
    }
    
    func rightBarButtonPressed(note: String) {
        isEditing.toggle()
        
        view?.updateTextViewEditableState(isEnabled: isEditing)
        if isEditing {
            view?.displayBarButton(title: "title.save")
        } else {
            view?.displayBarButton(title: "title.edit")
        }
    }
    
    // MARK: - Helpers
    func updateNote() {
        guard let note = view?.note else { return }
        
    }
    
}
