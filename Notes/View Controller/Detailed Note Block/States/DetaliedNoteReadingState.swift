//
//  DetaliedNoteReadingState.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

class DetaliedNoteVCReadingState: DetaliedNoteVCState {
    private weak var view: DetailedNoteView?
    
    init(view: DetailedNoteView) {
        self.view = view
    }
    
    // MARK: - DetaliedNoteVCState protocol
    func viewDidLoad() {
        view?.displayBarButton(item: .action)
        view?.updateTextViewEditableState(isEnabled: false)
    }
    
    func rightBarButtonPressed(note: String) {
        view?.shareNote(items: [note])
    }
}
