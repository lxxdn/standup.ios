//
//  TasksViewController.swift
//  Standup.ios
//
//  Created by julien on 6/6/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    private weak var tableView: UITableView!
    private var taskDataSource: UserDataSource?
    private var dataDelegate: UserTasksTableDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Standup"
        
        let myTableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        tableView = myTableView
        tableView.translatesAutoresizingMaskIntoConstraints = true
        taskDataSource = UserDataSource(tableView: tableView)
        tableView.dataSource = taskDataSource
        dataDelegate = UserTasksTableDelegate()
        tableView.delegate = dataDelegate
        
        self.view.addSubview(tableView!)
        
        DataLayer.getInstance().fetchTasks({ [weak self] data in
            if let dataSource = self?.taskDataSource{
                dataSource.data = data
            }
            if let dataDelegate = self?.dataDelegate{
                dataDelegate.data = data
            }
            dispatch_async(dispatch_get_main_queue(), {
                self?.tableView.reloadData()
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
