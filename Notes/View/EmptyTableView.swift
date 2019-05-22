//
//  EmptyTableView.swift
//  Notes
//
//  Created by Mediym on 5/21/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import UIKit

class EmptyTableView: UITableView {
    lazy var emptyView: UIView = {
        let emptyView = UIView(frame: bounds)
        emptyView.backgroundColor = .white
        
        titleLabel.text = title
        messageLabel.text = message
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        
        emptyView.addSubview(stackView)
        stackView.frame.size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        stackView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        
        //self.addSubview(emptyView)
        return emptyView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        messageLabel.numberOfLines = 0
        
        return messageLabel
    }()
    
    public var title: String = "No available notes" {
        didSet {
            titleLabel.text = title
        }
    }
    public var message: String = "But you can add by pressing plus button" {
        didSet {
            messageLabel.text = message
        }
    }
    
    //FIXME: Separator style
    func handleState() {
        backgroundView = isEmpty ? emptyView : nil
        isScrollEnabled = !isEmpty
    }
    
    var isEmpty: Bool = true {
        didSet {
            handleState()
        }
    }
    
}
