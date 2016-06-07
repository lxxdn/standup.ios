//
//  TaskDataSource.swift
//  Standup.ios
//
//  Created by julien on 6/7/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class TaskDataSource: NSObject, UITableViewDataSource{
    init(data: [ParsedProject]){
        super.init()
        self.data = data
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       return UITableViewCell()
    }
    private var data: [ParsedProject]
}