//
//  ViewController.swift
//  Notes
//
//  Created by Mediym on 5/20/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import UIKit

class NoteListVC: UIViewController {

    // MARK: - Data
    var data: [(String, Date)] = [("Some Text", Date())]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hideKeyboard()
    }
    
    // MARK: - Helpers
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func presentSortDireaction() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByDateAction = UIAlertAction(title: "Sort ascending", style: .default)
        let sortByLetterAction = UIAlertAction(title: "Sort descending", style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertVC.addAction(sortByDateAction)
        alertVC.addAction(sortByLetterAction)
        alertVC.addAction(cancel)
        
        present(alertVC, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func sortButtonTapped(_ sender: Any) {

        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByDateAction = UIAlertAction(title: "Sort by date", style: .default) { _ in
            self.presentSortDireaction()
        }
        let sortByLetterAction = UIAlertAction(title: "Sort by letters", style: .default) { _ in
            self.presentSortDireaction()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertVC.addAction(sortByDateAction)
        alertVC.addAction(sortByLetterAction)
        alertVC.addAction(cancel)
        
        // It calls autolayout error on iOS 12.2
        // Read more
        // https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints
        present(alertVC, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let vc = DetailedNoteVC.instantiate(fromAppStoryboard: .main)
        let state = DetaliedNoteInsertionState(view: vc, delegate: self)
        vc.state = state
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableViewDelegate protocol
extension NoteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let d = data[indexPath.item]
        let vc = DetailedNoteVC.instantiate(fromAppStoryboard: .main)
        let state = DetaliedNoteReadingState(view: vc)
        vc.state = state
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.data.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            
            let vc = DetailedNoteVC.instantiate(fromAppStoryboard: .main)
            let state = DetaliedNoteEditionState(view: vc)
            vc.state = state
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            handler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
}

// MARK: - UITableViewDataSource protocol
extension NoteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NoteCell.self, for: indexPath)
        let d = data[indexPath.item]
        cell.configure(note: d.0, date: d.1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}

// MARK: - DetaliedNoteInsertionStateDelegate protocol
extension NoteListVC: DetaliedNoteInsertionStateDelegate {
    func detailedNoteView(_ detailedNoteView: DetailedNoteView, didAdd note: String) {
        
    }
}
