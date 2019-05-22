//
//  ViewController.swift
//  Notes
//
//  Created by Mediym on 5/20/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import UIKit
import CoreData

class NoteListVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var noteTableView: EmptyTableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Data
    fileprivate var dataSource: TableViewDataSource<NoteListVC>!
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        localize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hideKeyboard()
    }
    
    // MARK: - Setup
    func localize() {
        navigationItem.title = s("title.notes")
        searchBar.placeholder = s("title.search")
    }
    
    fileprivate func setupTableView() {
        noteTableView.tableFooterView = UIView()
        noteTableView.title = s("title.emptyTable")
        noteTableView.message = s("subtitle.emptyTable")
        
        let request = Note.sortedFetchRequest
        request.fetchBatchSize = 20
        request.returnsObjectsAsFaults = false
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: managedObjectContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        dataSource = TableViewDataSource(tableView: noteTableView,
                                         fetchedResultsController: frc,
                                         delegate: self)
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
        let state = DetaliedNoteInsertionState(view: vc,
                                               context: managedObjectContext)
        
        vc.state = state
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableViewDelegate protocol
extension NoteListVC: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailedNoteVC.instantiate(fromAppStoryboard: .main)
        let state = DetaliedNoteReadingState(view: vc)
        let note = dataSource.objectAtIndexPath(indexPath)
        vc.setup(state: state, note: note)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: s("title.delete")) {
            (action, view, handler) in

            let note = self.dataSource.objectAtIndexPath(indexPath)
            note.managedObjectContext?.performChanges {
                note.managedObjectContext?.delete(note)
            }
            
            handler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: s("title.edit")) {
            (action, view, handler) in
            
            let vc = DetailedNoteVC.instantiate(fromAppStoryboard: .main)
            let note = self.dataSource.objectAtIndexPath(indexPath)
            let state = DetaliedNoteEditionState(view: vc)
            vc.setup(state: state, note: note)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            handler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
}

// MARK: - TableViewDataSourceDelegate
extension NoteListVC: TableViewDataSourceDelegate {
    typealias Object = Note
    typealias Cell = NoteCell
    
    func configure(_ cell: NoteCell, for object: Note) {
        cell.configure(note: object.text, date: object.date)
    }
    
    func tableView(_ tableView: UITableView, didUpdateRowNubmer count: Int) {
        noteTableView.isEmpty = count == 0
    }
}
