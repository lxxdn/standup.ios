//
//  TaskTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 4/5/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class TaskTableViewCell: UITableViewCell {

    var checkbox =  M13Checkbox()
    var id: String?

    override func layoutSubviews() {
        super.layoutSubviews()
        checkbox.frame.origin.y = (self.frame.height - checkbox.frame.height)/2
        self.addSubview(checkbox)
        self.textLabel!.frame.origin.x = 30
    }
}
