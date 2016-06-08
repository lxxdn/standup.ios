//
//  TasksViewController.swift
//  Standup.ios
//
//  Created by julien on 6/6/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    private weak var tableView: UITableView?
    private var taskDataSource: TaskDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Standup"
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        taskDataSource = TaskDataSource(tableView: tableView!)
        tableView!.dataSource = taskDataSource
        
        self.view.addSubview(tableView!)
        
        DataLayer.getInstance().fetchTasks({ [unowned self] data in
            if let dataSource = self.taskDataSource{
                dataSource.data = data
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
