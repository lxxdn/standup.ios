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
        var tableCell = tasksTable.dequeueReusableCellWithIdentifier("taskCell")
        
        if tableCell == nil {
            tableCell = TaskTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "taskCell")
            let checkbox = M13Checkbox()
            checkbox.frame.origin.y = (tableCell!.frame.height - checkbox.frame.height)/2
            checkbox.addTarget(self, action: #selector(checkChangedValue(_:)), forControlEvents: .ValueChanged)
            tableCell?.addSubview(checkbox)
            
            //tableCell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            tableCell!.selectionStyle = .None
        }
        
        if tasks.count > 0 {
            let task = tasks[indexPath.row] as Task
            let attributeString =  NSMutableAttributedString(string: task.content!)
            if task.status == .Done{
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
            }
            tableCell!.textLabel?.attributedText = attributeString
        }
        
        
        return tableCell!
    }
    
    func checkChangedValue(sender: M13Checkbox){
        let tableCell = sender.superview as! TaskTableViewCell
        let attributeString =  NSMutableAttributedString(string: tableCell.textLabel!.text!)
        if sender.checkState == .Checked{
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
        }else if sender.checkState == .Unchecked{
            attributeString.removeAttribute(NSStrikethroughStyleAttributeName, range: NSMakeRange(0, attributeString.length))
        }
        //alamofire send api request to update status
        
        //update self data strucutre
        
        
        tableCell.textLabel!.attributedText = attributeString
    }
    
}
