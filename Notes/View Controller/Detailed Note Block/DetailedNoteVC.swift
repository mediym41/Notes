//
//  DetailedNoteVC.swift
//  Notes
//
//  Created by Mediym on 5/20/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

protocol DetaliedNoteVCState {
    func rightBarButtonPressed(note: String)
    func viewDidLoad()
}

protocol DetailedNoteView: class {
    var note: Note? { get }
    func updateTextViewEditableState(isEnabled: Bool)
    func shareNote(items: [Any])
    func updateKeyboard(isEnabled: Bool)
    func dissmiss()
    func displayBarButton(title: String)
    func displayBarButton(item: UIBarButtonItem.SystemItem)
    func displayNote(text: String)
    func displayError(title: String, message: String)
}

class DetailedNoteVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var noteTextView: IQTextView!
    
    // MARK: - State
    var state: DetaliedNoteVCState!
    var note: Note?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state.viewDidLoad()
        setupNoteTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if noteTextView.isEditable {
            updateKeyboard(isEnabled: true)
        }
    }
    
    // MARK: - Setup
    func setup(state: DetaliedNoteVCState, note: Note?) {
        self.state = state
        self.note = note
    }
    
    func setupNoteTextView() {
        noteTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        noteTextView.inputAccessoryView = nil
        noteTextView.text = note?.text
    }
    
    // MARK: - Selectors
    @objc func rightBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let note = noteTextView.text else { return }
        state.rightBarButtonPressed(note: note)
    }
}

// MARK: - DetailedNoteView protocol
extension DetailedNoteVC: DetailedNoteView {
    func updateTextViewEditableState(isEnabled: Bool) {
        noteTextView.isEditable = isEnabled
        noteTextView.inputAccessoryView = nil
    }
    
    func shareNote(items: [Any]) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view // fix for iPads
        present(activityVC, animated: true)
    }
    
    func updateKeyboard(isEnabled: Bool) {
        if isEnabled {
            noteTextView.becomeFirstResponder()
        } else {
            noteTextView.resignFirstResponder()
        }
    }
    
    func dissmiss() {
        performSegueToReturnBack()
    }
    
    func displayBarButton(title: String) {
        if let barButton = navigationItem.rightBarButtonItem {
            barButton.title = s(title)
        } else {
            let rightBarButton = UIBarButtonItem(title: s(title),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(rightBarButtonPressed(_:)))
            navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    func displayBarButton(item: UIBarButtonItem.SystemItem) {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: item,
                                         target: self,
                                         action: #selector(rightBarButtonPressed(_:)))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    func displayNote(text: String) {
        noteTextView.text = s(text)
    }
    
    func displayError(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: s("title.ok"), style: .cancel)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true)
    }
}
