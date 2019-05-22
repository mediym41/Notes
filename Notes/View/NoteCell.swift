//
//  NoteCell.swift
//  Notes
//
//  Created by Mediym on 5/20/19.
//  Copyright © 2019 NSMedium. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(note: String, date: Date) {
        let dateTime = date.formatted(format: "dd.MM.yyyy hh:mm")
        let components = dateTime.split(separator: " ").map { String($0) }
        dateLabel.text = components[0]
        timeLabel.text = components[1]
        
        let isLargeNote = note.count > 100
        noteLabel.text = isLargeNote ? note.substring(to: 100) : note
    }

}
