//
//  TaskFormViewController.swift
//  Standup.ios
//
//  Created by julien on 4/10/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class TaskFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: embeded structure
    enum DataType {
        case User
        case Project
    }
    //MARK: property
    weak var taskForm: TaskFormView!
    var projects: [Project] = []{
        didSet{
            taskForm.selectView.reloadData()
        }
    }
    var users: [Employee] = [] {
        didSet{
            taskForm.selectView.reloadData()
        }
    }
    var currentUser: Employee? = nil {
        didSet{
            taskForm.userBtn.setTitle( currentUser!.name, forState: UIControlState.Normal)
        }
    }
    var currentProject: Project? = nil {
        didSet{
            taskForm.projectBtn.setTitle( currentProject!.name, forState: UIControlState.Normal)
        }
    }
    var currentDataType = DataType.Project
    var data: [Dictionary<String, String>] {
        get{
            var result: [Dictionary<String, String>]
            switch currentDataType{
            case .Project:
                result = projects.map({
                    project in
                    ["project_id": project.id, "project_name": project.name]
                })
            case .User:
                result = users.map({
                    user in
                    ["employee_id": user.id, "employee_name": user.name, "avatar": user.avatar, "team_id": user.team_id]
                })
            }
           return result
        }
    }
    

    //MARK: life cycle
    override func loadView() {
        super.loadView()
        taskForm = NSBundle.mainBundle().loadNibNamed("TaskFormView", owner: nil, options: nil).first as! TaskFormView
        self.view = taskForm
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskForm.cancelBtn.addTarget(self, action: #selector(cancel(_:)), forControlEvents: .TouchDown)
        taskForm.submitBtn.addTarget(self, action: #selector(submit), forControlEvents: .TouchDown)
        taskForm.projectBtn.addTarget(self, action: #selector(selectProject(_:)), forControlEvents: .TouchDown)
        taskForm.userBtn.addTarget(self, action: #selector(selectUser(_:)), forControlEvents: .TouchDown)
        
        taskForm.selectView.dataSource = self
        taskForm.selectView.delegate = self
        
        //set current user
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let savedCurrentUserJSON = (userDefault.objectForKey("current_user") as? Dictionary<String, String>){
            if let user = Employee(data: savedCurrentUserJSON){
                self.currentUser = user
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: target actions
    func cancel(btn: UIButton){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func submit() {
//        let params = ["content": taskForm.taskContentInput.text, "project_id": currentProject.id, "team_id": currentUser.!, "user_id": currentUser!["id"]! ]
//        
//        Alamofire.request(.POST, "http://nuri.ekohe.com:4567/task/create", parameters: params, encoding: .JSON)
//            .validate(statusCode: 200..<300)
//            .response{  response in
//                print(response)
//                //                self.parent?.refresh()
//        }
//        UIView.animateWithDuration(0.5, animations: {
//            self.frame.origin.y += UIScreen.mainScreen().bounds.height
//        })
//        self.selectView.hidden = true
//        self.endEditing(true)
    }

    func selectProject(btn: UIButton){
        taskForm.endEditing(true)
        
        let cachedData = ArchivedKeyCache.load("project_list")
        
        if let projectsJSON = cachedData as? Array<NSDictionary>{
            self.projects = Project.parseJSON(projectsJSON)
        }
        self.currentDataType = .Project
        
        Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allProjects")
            .responseJSON{ [unowned self]response in
                switch response.result {
                case .Success(let json):
                    if let projectsJSON = json as? NSDictionary{
                        let projectsData = projectsJSON.objectForKey("projects") as! [Dictionary<String, String>]
                        self.projects = Project.parseJSON(projectsData)
                        ArchivedKeyCache.save(projectsData, filename: "project_list")
                    }
                case .Failure(let error):
                    NSLog("Failed to get projects josn becase \(error)")
                }
        }
        showTableView()
        
    }
    
    func selectUser(btn: UIButton){
        taskForm.endEditing(true)
        let cachedData = ArchivedKeyCache.load("user_list")
        
        if let usersJSON = cachedData as? Array<NSDictionary>{
            self.users = Employee.parseJSON(usersJSON)
        }
        self.currentDataType = .User
        
        Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allUsers")
            .responseJSON{ [unowned self] response in
                switch response.result {
                case .Success(let json):
                    if let usersJSON = json as? NSDictionary{
                        let usersData = usersJSON.objectForKey("users") as! [Dictionary<String, String>]
                        self.users = Employee.parseJSON(usersData)
                        ArchivedKeyCache.save(usersData, filename: "user_list")
                    }
                case .Failure(let error):
                    NSLog("Failed to get projects josn becase \(error)")
                }
        }
        showTableView()

    }
    
    // MARK: tableview datasource and delegate actions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableCell = taskForm.selectView.dequeueReusableCellWithIdentifier(taskForm.tableCellIdentifier)
        let cell: UITableViewCell
        if tableCell != nil{
            cell = tableCell!
        }else{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: taskForm.tableCellIdentifier)
        }
        
        if currentDataType == .User{
            cell.textLabel?.text = self.data[indexPath.row]["employee_name"]
        }else{
             cell.textLabel?.text = self.data[indexPath.row]["project_name"]
        }
       
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if currentDataType == .User{
            if let employee = Employee(data: data[indexPath.row]){
                currentUser = employee
            }
        }else{
            if let project = Project(data: data[indexPath.row]){
                currentProject = project
            }
        }
        hideTableView()
    }
    
    // MARK: other functions
    func showTableView(){
        taskForm.selectView.reloadData()
        UIView.animateWithDuration(0.5, animations: {[unowned self] in
            self.taskForm.selectView.frame.origin.y -= (self.taskForm.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - 20) // todo replace 20 by a more meaningful stuff
        })
    }
    
    func hideTableView(){
        UIView.animateWithDuration(0.5, animations: { [unowned self] in
            self.taskForm.selectView.frame.origin.y = self.taskForm.frame.height
        })
    }
    
    
}
