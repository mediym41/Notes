//
//  DetaliedNoteInsertionState.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

protocol DetaliedNoteInsertionStateDelegate: class {
    func detailedNoteView(_ detailedNoteView: DetailedNoteView, didAdd note: String)
}

class DetaliedNoteInsertionState: DetaliedNoteState {
    private weak var view: DetailedNoteView?
    private weak var delegate: DetaliedNoteInsertionStateDelegate?
    
    init(view: DetailedNoteView, delegate: DetaliedNoteInsertionStateDelegate?) {
        self.view = view
        self.delegate = delegate
    }
    
    // MARK: - DetaliedNoteState protocol
    func viewDidLoad() {
        view?.updateTextViewEditableState(isEnabled: true)
        view?.displayBarButton(title: "title.save")
        //view?.showKeyboard()
    }
    
    func rightBarButtonPressed(note: String) {
        guard let view = view else { return }
        delegate?.detailedNoteView(view, didAdd: note)
    }
}
