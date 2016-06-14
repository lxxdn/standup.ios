//
//  ArrayTableViewDelegate.swift
//  
//
//  Created by julien on 6/14/16.
//
//

import Foundation

class UserTasksTableDelegate:NSObject, UITableViewDelegate{
    var data: [ParsedTask]?
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 100
        if let data = data{
            height += CGFloat(data[indexPath.section].users[indexPath.row].tasks.count * 45)
        }
        return height
    }
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}