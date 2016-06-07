//
//  TasksViewController.swift
//  Standup.ios
//
//  Created by julien on 6/6/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Standup"
        
        tableView.frame = UIScreen.mainScreen().bounds
        tableView.dataSource =
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
