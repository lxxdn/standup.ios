//
//  TaskTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 4/5/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel!.frame.origin.x = 30
    }
}
