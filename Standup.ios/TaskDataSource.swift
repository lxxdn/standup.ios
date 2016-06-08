//
//  TaskDataSource.swift
//  Standup.ios
//
//  Created by julien on 6/7/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class TaskDataSource: NSObject, UITableViewDataSource{
    private let tableView: UITableView

    var data: [ParsedTask]? = nil {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    init(tableView: UITableView){
        self.tableView = tableView
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        if let data = data{
            result = data.count
        }
        return result
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell: UserTasksCellTableViewCell? = tableView.dequeueReusableCellWithIdentifier("UserTaskCell") as? UserTasksCellTableViewCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("UserTasksCellTableViewCell", owner: nil, options: nil)[0] as? UserTasksCellTableViewCell
        }
        cell?.configWithData(data![indexPath.row])
        return cell!
    }
}