//
//  PersonWithTasksTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 2/25/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class PersonWithTasksTableViewCell: UITableViewCell {
    @IBOutlet weak var employeeAvatar: UIImageView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var tasksTable: UITableView!
    
    var user: Employee?
    var project: Project?
    
    var tasks = [Task](){
        didSet{
            tasksTable.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tasksTable.scrollEnabled = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
