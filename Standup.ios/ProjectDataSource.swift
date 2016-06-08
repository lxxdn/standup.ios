//
//  ProjectDataSource.swift
//  Standup.ios
//
//  Created by julien on 6/8/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class ProjectDataSource: NSObject, UITableViewDataSource{
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
        
    }
}