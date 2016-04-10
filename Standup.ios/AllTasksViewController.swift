//
//  AllTasksViewController.swift
//  Standup.ios
//
//  Created by julien on 2/17/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class AllTasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    @IBOutlet weak var tasksTableView: UITableView!

    @IBOutlet weak var addBtn: UIButton!
    @IBAction func newTaskPressed(sender: UIButton) {
        let addTaskViewController = AddTaskViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(addTaskViewController, animated: true)
    }
    @IBAction func newTaskPressedDown() {
        var frame = addBtn.frame
        let center = CGPoint(x: frame.origin.x + frame.width/2 , y: frame.origin.y + frame.height/2)
        
        frame.size = CGSize(width: frame.width*6/7, height: frame.height*6/7)
        frame.origin = CGPoint(x: center.x - frame.size.width/2, y: center.y - frame.size.height/2)
        
        addBtn.frame = frame
    }
    
    var projects: Array<Project> = []{
        didSet{
            self.tasksTableView.reloadData()
        }
    }
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        
        self.navigationItem.title = "Standup"
        
        
        if !Login.isLoggedIn(){
            self.navigationController?.pushViewController(LogInControllerViewController(), animated: false)
        }
        
        //set button image
        let buttonImage = UIImage(named: "add_task_icon")
        addBtn.setImage(buttonImage, forState: UIControlState.Normal)
        addBtn.setImage(buttonImage, forState: UIControlState.Highlighted)
        
        // set activity indicator
        let screenSize = UIScreen.mainScreen().bounds
        spinner.frame.origin = CGPoint(x: (screenSize.width - spinner.frame.width)/2, y: (screenSize.height - spinner.frame.height)/2)
        self.view.addSubview(spinner)
        
        // refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), forControlEvents: .ValueChanged)
        tasksTableView.addSubview(refreshControl)
        
        spinner.hidden = true
        spinner.startAnimating()
        self.refresh()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refresh(refreshControl: UIRefreshControl) {
        // Do your job, when done:
        refresh()
        refreshControl.endRefreshing()
    }

    
    func refresh(){

        Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allTasks")
            .responseJSON{ response in
                switch response.result{
                case .Success(let json):
                    let tasksJSON = json as! NSDictionary
                    self.projects = Project.parseJSON(tasksJSON.objectForKey("projects"))
                    self.spinner.stopAnimating()
                    self.spinner.hidden = true
                case .Failure(let error):
                    NSLog("Failed to get tasks json because \(error)" )
                }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects[section].employees.count
    }
    
    private struct StaticData{
       static let tableCellResuseIdentifier = "PersonWithTask"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCellWithIdentifier(StaticData.tableCellResuseIdentifier)
        
        var cell: PersonWithTasksTableViewCell
        if (tableCell != nil){
            cell = tableCell as! PersonWithTasksTableViewCell
        }else{
            cell = NSBundle.mainBundle().loadNibNamed("PersonWithTasksTableViewCell", owner: nil, options: nil).first as! PersonWithTasksTableViewCell
        }
        cell.tasksTable.delegate = self
        let project = self.projects[indexPath.section]
        
        cell.employeeName.text = project.employees[indexPath.row].name.capitalizedString
        cell.employeeAvatar.sd_setImageWithURL(NSURL(string: project.employees[indexPath.row].avatar))
        
        cell.tasks = project.employees[indexPath.row].tasks
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return projects[section].name
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tasksTableView == tableView{
            let defaultCellHeight = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
            let height = 70 + (CGFloat)(projects[indexPath.section].employees[indexPath.row].tasks.count) * defaultCellHeight.frame.height
            return CGFloat(height)
        }
        return UITableViewCell().frame.height
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView != tasksTableView {
            let cellContentView = tableView.superview
//            let cell = cellContentView?.superview as! PersonWithTasksTableViewCell
//            self.navigationController?.pushViewController(UpdateTaskViewController(), animated: true)
            
        }
    }
    
    
}
