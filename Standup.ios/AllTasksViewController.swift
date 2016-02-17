//
//  AllTasksViewController.swift
//  Standup.ios
//
//  Created by julien on 2/17/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

class AllTasksViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var tasksTableView: UITableView!
    
    var projects = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        tasksTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initData(){
    
    }
    
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "personWithTasks"
        let tableCell = tableView.dequeueReusableCellWithIdentifier(cellID)
            
        return tableCell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
