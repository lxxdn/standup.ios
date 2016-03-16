//
//  PersonWithTasksTableViewCell.swift
//  Standup.ios
//
//  Created by julien on 2/25/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class PersonWithTasksTableViewCell: UITableViewCell, UITableViewDataSource {
    @IBOutlet weak var employeeAvatar: UIImageView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var tasksTable: UITableView!
    
    var tasks = [String](){
        didSet{
            tasksTable.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tasksTable.dataSource = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableCell = tasksTable.dequeueReusableCellWithIdentifier("taskCell")
        
        if tableCell == nil {
            tableCell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "taskCell")
            //tableCell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            tableCell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        if tasks.count > 0 {
            tableCell!.textLabel?.text = tasks[indexPath.row]
        }
        
        return tableCell!
    }
    
}
