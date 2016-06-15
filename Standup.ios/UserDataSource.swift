//
//  TaskDataSource.swift
//  Standup.ios
//
//  Created by julien on 6/7/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class UserDataSource: NSObject, UITableViewDataSource{
    private let tableView: UITableView

    var data: [ParsedTask]? = nil
   
    
    init(tableView: UITableView){
        self.tableView = tableView
        let nib = UINib(nibName: "UserTasksCellTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "UserTasksCell")
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       var result = 0
        if let data = data{
            result = data[section].users.count
        }
       return result
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        var result = 0
        if let data = data{
            result = data.count
        }
        return result
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UserTasksCellTableViewCell? = (tableView.dequeueReusableCellWithIdentifier("UserTasksCell") as! UserTasksCellTableViewCell)
        
        if let data = data{
            cell!.configWithData(data[indexPath.section].users[indexPath.row])
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data?[section].project_name
    }
}