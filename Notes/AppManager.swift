//
//  AppManager.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//


import UIKit

class AppManager {
    
    public static let shared = AppManager()
    
    private init() { }
    
    let coreDataStack = CoreDataStack()
    private var window: UIWindow?
    
    public func startup(window: UIWindow?) {
        self.window = window
        
        setupAndShowInitialScreen()
    }
    
    private func setupAndShowInitialScreen() {
        let rootVC = NoteListVC.instantiate(fromAppStoryboard: .main)
        rootVC.managedObjectContext = coreDataStack.persistentContainer.viewContext
        let navigationVC = UINavigationController(rootViewController: rootVC)
        
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
    }

}
