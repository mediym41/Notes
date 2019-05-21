//
//  Extension+UIKit.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//


import UIKit

// MARK: - ViewController
extension UIViewController {
    static var name: String {
        return String(describing: self)
    }
    
    class func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    
    func performSegueToReturnBack() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - View
extension UIView {
    static var name: String {
        return String(describing: self)
    }
}

// MARK: - UITableView
extension UITableView {
    func register(type: UITableViewCell.Type) {
        let typeName = type.name
        let nib = UINib(nibName: typeName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: typeName)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.name, for: indexPath) as! T
    }
}
