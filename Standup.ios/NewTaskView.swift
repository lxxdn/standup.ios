//
//  NewTaskView.swift
//  Standup.ios
//
//  Created by julien on 3/14/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class NewTaskView: UIView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    enum DataType {
        case User
        case Project
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var projectBtn: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    var parent: AllTasksViewController?
    @IBAction func submit() {
        let params = ["content": taskContentInput.text, "project_id": currentProject!["id"]!, "team_id": currentUser!["team_id"]!, "user_id": currentUser!["id"]! ]

        Alamofire.request(.POST, "http://nuri.ekohe.com:4567/task/create", parameters: params, encoding: .JSON)
        UIView.animateWithDuration(0.5, animations: {
            self.frame.origin.y += UIScreen.mainScreen().bounds.height
            })
        self.selectView.hidden = true
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(currentUser, forKey: "current_user")
    }
    
    
    @IBAction func cancel() {
        UIView.animateWithDuration(0.5, animations: {
            self.frame.origin.y += self.frame.height
            
            self.frame.origin.y += UIScreen.mainScreen().bounds.height
            })
        self.selectView.hidden = true
    }
    
    var currentUser: NSDictionary?{
        didSet{
            if let name = currentUser?.objectForKey("name") as? String {
                userBtn.setTitle( name, forState: UIControlState.Normal)
            }
        }
    }
    var currentProject: NSDictionary?{
        didSet{
            if let name = currentProject?.objectForKey("name") as? String {
                projectBtn.setTitle( name, forState: UIControlState.Normal)
            }
        }
    }
    var currentDataType = DataType.Project
    let selectView = UITableView()
    var data = [NSDictionary](){
        didSet{
            selectView.reloadData()
        }
    }//id and name tuple
    
    @IBAction func selectProject() {
        self.endEditing(true)
        let cachedData = ArchivedKeyCache.load("project_list")
        if let projects = cachedData as? Array<NSDictionary>{
            self.data = projects
        }else{
            Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allProjects")
                .responseJSON{ response in
                    switch response.result {
                    case .Success(let json):
                        let projectsJSON = json as! NSDictionary
                        if self.data != projectsJSON.objectForKey("projects") as! Array<NSDictionary>{
                            self.data = projectsJSON.objectForKey("projects") as! Array<NSDictionary>
                            ArchivedKeyCache.save(self.data, filename: "project_list")
                        }
                    case .Failure(let error):
                        NSLog("Failed to get projects josn becase \(error)")
                    }
            }
        }
        
        self.currentDataType = .Project
        UIView.animateWithDuration(0.5, animations: {
            self.selectView.frame.origin.y = 0
        })

    }

    @IBAction func selectUser() {
        self.endEditing(true)
        let cachedData = ArchivedKeyCache.load("user_list")
        if let users = cachedData as? Array<NSDictionary>{
            self.data = users
        }else{
            Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allUsers")
                .responseJSON{ response in
                    switch response.result {
                    case .Success(let json):
                        let usersJSON = json as! NSDictionary
                        if self.data != usersJSON.objectForKey("users") as! Array<NSDictionary>{
                            self.data = usersJSON.objectForKey("users") as! Array<NSDictionary>
                            ArchivedKeyCache.save(self.data, filename: "user_list")
                        }
                    case .Failure(let error):
                        NSLog("Failed to get users josn becase \(error)")
                    }
            }
        }
        self.currentDataType = .User
        UIView.animateWithDuration(0.5, animations: {
            self.selectView.frame.origin.y = 0
        })
    }
    
    @IBOutlet weak var taskContentInput: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        taskContentInput.text = ""
        taskContentInput.placeholder = "Input your content"
        taskContentInput.becomeFirstResponder()
        
        selectView.dataSource = self
        selectView.delegate = self
        selectView.frame.size = UIScreen.mainScreen().bounds.size
        selectView.frame.origin.y = UIScreen.mainScreen().bounds.height
        self.addSubview(selectView)
        
        //set current user
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let savedCurrentUser = (userDefault.objectForKey("current_user") as? NSDictionary){
            self.currentUser = savedCurrentUser
        }
        
        // add gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTaskView.tapViewAction(_:)))
        self.mainView.addGestureRecognizer(tapRecognizer)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tapViewAction(recognizer: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableCell = selectView.dequeueReusableCellWithIdentifier("selectCell")
        if tableCell == nil{
           tableCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "selectCell")
        }
        let cell = tableCell!
        
        cell.textLabel?.text = self.data[indexPath.row].objectForKey("name") as? String
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.currentDataType == .User{
            currentUser = data[indexPath.row]
        }else{
            currentProject = data[indexPath.row]
        }
        UIView.animateWithDuration(0.5, animations: {
            self.selectView.frame.origin.y = self.frame.height
        })
        
    }
}
