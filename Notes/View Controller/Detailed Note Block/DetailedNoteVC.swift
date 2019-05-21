//
//  DetailedNoteVC.swift
//  Notes
//
//  Created by Mediym on 5/20/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import UIKit
import CoreData

protocol DetaliedNoteState {
    func rightBarButtonPressed(note: String)
    func viewDidLoad()
}

protocol DetailedNoteView: class {
    var note: Note? { get }
    func updateTextViewEditableState(isEnabled: Bool)
    func rightBarButtonPressed(note: String)
    func shareNote(items: [Any])
    func showKeyboard()
    func dissmiss()
    func displayBarButton(title: String)
    func displayBarButton(item: UIBarButtonItem.SystemItem)
}

class DetailedNoteVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var noteTextView: UITextView!
    
    // MARK: - State
    var state: DetaliedNoteState!
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
            showKeyboard()
        }
    }
    
    // MARK: - Setup
    func setupNoteTextView() {
        noteTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        if let note = note {
            noteTextView.text = note.text
        }
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
    }
    
    func rightBarButtonPressed(note: String) {
        
    }
    
    func shareNote(items: [Any]) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    func showKeyboard() {
        noteTextView.becomeFirstResponder()
    }
    
    func dissmiss() {
        performSegueToReturnBack()
    }
    
    func displayBarButton(title: String) {
        let rightBarButton = UIBarButtonItem(title: title,
                                         style: .plain,
                                         target: self,
                                         action: #selector(rightBarButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func displayBarButton(item: UIBarButtonItem.SystemItem) {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: item,
                                         target: self,
                                         action: #selector(rightBarButtonPressed(_:)))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    
}
