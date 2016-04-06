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
    
    var tasks = [Task](){
        didSet{
            tasksTable.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tasksTable.dataSource = self
        tasksTable.scrollEnabled = false
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
        var tableCell = tasksTable.dequeueReusableCellWithIdentifier("taskCell") as?  TaskTableViewCell
        
        if tableCell == nil {
            tableCell = TaskTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "taskCell")
            tableCell?.checkbox = M13Checkbox()
                        
            //tableCell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            tableCell!.selectionStyle = .None
        }
        
        if tasks.count > 0 {
            let task = tasks[indexPath.row] as Task
            let attributeString =  NSMutableAttributedString(string: task.content!)
            tableCell!.id = task.id
            if task.status == .Done{
                tableCell!.checkbox?.checkState = .Checked
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
            }
            tableCell!.textLabel?.attributedText = attributeString
        }
        
        
        return tableCell!
    }
    
        
}
