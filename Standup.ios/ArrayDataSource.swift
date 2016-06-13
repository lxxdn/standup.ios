//
//  TaskDataSource.swift
//  Standup.ios
//
//  Created by julien on 6/13/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class ArrayDataSource: NSObject, UITableViewDataSource{
    private let tableView: UITableView
    private let cellIdentifier: String
    
    var data: [AnyObject]? = nil {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    init(tableView: UITableView, nibName: String, cellIdentifier: String){
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if let cell = cell as? CellConfigurable{
            cell.configWithData(data!)
        }
        return cell!
    }
    
    
}