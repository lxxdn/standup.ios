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
    
    //MARK: property
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)

    var projects: Array<Project> = []{
        didSet{
            self.tasksTableView.reloadData()
        }
    }
    private struct StaticData{
        static let tableCellResuseIdentifier = "PersonWithTask"
    }
    
    //MARK: actions
    @IBAction func newTaskPressed(sender: UIButton) {
        let addTaskViewController = AddTaskViewController(nibName: nil, bundle: nil)
        addTaskViewController.refreshFn = refresh
        self.navigationController?.pushViewController(addTaskViewController, animated: true)
    }
    @IBAction func newTaskPressedDown() {
        var frame = addBtn.frame
        let center = CGPoint(x: frame.origin.x + frame.width/2 , y: frame.origin.y + frame.height/2)
        
        frame.size = CGSize(width: frame.width*6/7, height: frame.height*6/7)
        frame.origin = CGPoint(x: center.x - frame.size.width/2, y: center.y - frame.size.height/2)
        
        addBtn.frame = frame
    }
    
    
    //MARK: life cycle
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
    
    //MARK: tableview datasource and delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var result = 1
        if tableView == tasksTableView {
            result = projects.count
        }
        return result
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result: Int
        if tableView == tasksTableView{
            result = projects[section].employees.count
        }else{
            let cell = tableView.superview?.superview as! PersonWithTasksTableViewCell
            result = cell.tasks.count
        }
        return result
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tasksTableView{
            let tableCell = tableView.dequeueReusableCellWithIdentifier(StaticData.tableCellResuseIdentifier)
            
            var project2TasksCell: PersonWithTasksTableViewCell
            if (tableCell != nil){
                project2TasksCell = tableCell as! PersonWithTasksTableViewCell
            }else{
                project2TasksCell = NSBundle.mainBundle().loadNibNamed("PersonWithTasksTableViewCell", owner: nil, options: nil).first as! PersonWithTasksTableViewCell
            }
            project2TasksCell.tasksTable.dataSource = self
            project2TasksCell.tasksTable.delegate = self
            let project = self.projects[indexPath.section]
            
            project2TasksCell.user = project.employees[indexPath.row]
            project2TasksCell.employeeName.text = project.employees[indexPath.row].name.capitalizedString
            project2TasksCell.employeeAvatar.sd_setImageWithURL(NSURL(string: project.employees[indexPath.row].avatar))
            project2TasksCell.project = project
            project2TasksCell.tasks = project.employees[indexPath.row].tasks

            cell = project2TasksCell
        }else if let personWithTasksCell =  tableView.superview?.superview as? PersonWithTasksTableViewCell{
            
            var tableCell = personWithTasksCell.tasksTable.dequeueReusableCellWithIdentifier("taskCell") as? TaskTableViewCell
            
            if tableCell == nil {
                tableCell = TaskTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "taskCell")
                tableCell!.checkbox.addTarget(self, action: #selector(checkChangedValue(_:)), forControlEvents: .ValueChanged)
                
                //tableCell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                tableCell!.selectionStyle = .Gray
            }
            
            // add attributed string if it's done
            let tasks = personWithTasksCell.tasks
            if tasks.count > 0 {
                let task = tasks[indexPath.row] as Task
                let attributeString =  NSMutableAttributedString(string: task.content)
                tableCell!.id = task.id
                if task.status == .Done{
                    tableCell!.checkbox?.checkState = .Checked
                    attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
                    attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
                }
                tableCell!.textLabel?.attributedText = attributeString
            }
            cell = tableCell!
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tasksTableView{
            return projects[section].name

        }
        return nil
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
            let cell = cellContentView?.superview as! PersonWithTasksTableViewCell
            let task = cell.tasks[indexPath.row]
            let updateTaskController = UpdateTaskViewController()
            updateTaskController.task = task
            updateTaskController.refreshFn = refresh
            if let p = cell.project{
                updateTaskController.project = p
            }
            if let u = cell.user{
                updateTaskController.user = u
            }
            self.navigationController?.pushViewController(updateTaskController, animated: true)
        }
    }
    
    //MARK: self-defined functions
    func refresh(refreshControl: UIRefreshControl) {
        // Do your job, when done:
        refresh()
        refreshControl.endRefreshing()
    }
    
    func refresh(){
        let date = NSDate()
        let dateFomatter = NSDateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd"
        let today = dateFomatter.stringFromDate(date)
        Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allTasks?date=\(today)")
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
    
    func deleteLocalTask(project_id: String, employee_id: String, task:Task){
        findTask(project_id, employee_id: employee_id, method: { employee in
            let taskIndex = employee.tasks.indexOf { $0.id == task.id }
            if let i = taskIndex {
                employee.tasks.removeAtIndex(i)
            }
        })
        tasksTableView.reloadData()
        
    }
    
    func addLocalTask(project_id: String, employee_id: String, task: Task){
        findTask(project_id, employee_id: employee_id, method: { employee in
            employee.tasks.append(task)
        })
        tasksTableView.reloadData()
    }
    func findTask(project_id: String, employee_id: String ,method: (employee: Employee)->()){
        let projectIndex = projects.indexOf{ $0.id == project_id }
        if let i = projectIndex {
            let employees = projects[i].employees.filter{ $0.id == employee_id }
            if employees.count > 0{
                method(employee: employees[0])
            }
        }
    }
    
    func checkChangedValue(sender: M13Checkbox){
        let tableCell = sender.superview as! TaskTableViewCell
        let attributeString =  NSMutableAttributedString(string: tableCell.textLabel!.text!)
        // from unchecked to checked
        
        var status = "done"
        if sender.checkState == .Checked{
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
        }else if sender.checkState == .Unchecked{ // from check to unchecked
            attributeString.removeAttribute(NSStrikethroughStyleAttributeName, range: NSMakeRange(0, attributeString.length))
            status = "new"
        }
        
        if let givenID = tableCell.id {
            Alamofire.request(.PUT, "http://nuri.ekohe.com:4567/updateTaskStatus/\(givenID)", parameters: ["status": status], encoding: .JSON)
                .validate(statusCode: 200..<300)
                .response { response in
                    print(response.3)
                
            }
        }
        
        //alamofire send api request to update status
        
        //update self data strucutre
        
        
        tableCell.textLabel!.attributedText = attributeString
    }

    
}
