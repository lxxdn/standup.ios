//
//  TaskCell.swift
//  Standup.ios
//
//  Created by julien on 6/13/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, CellConfigurable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configWithData(data: AnyObject) {
        if let data = data as? Task{
            textLabel?.text = data.content
        }
    }
    
}
