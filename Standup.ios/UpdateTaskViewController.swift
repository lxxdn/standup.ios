//
//  TaskUpdateViewController.swift
//  Standup.ios
//
//  Created by julien on 4/10/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class UpdateTaskViewController: TaskFormViewController {
    var task: Task?
    var project: Project?
    var user : Employee?
    var deleteTaskOnLocal: ((String, String, Task) -> ())?
    var addTaskOnLocal : ((String, String, Task) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskForm.taskContentInput.text = task!.content
        if let p = project{
            currentProject = p
        }
        if let u = user{
            currentUser = u
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // update
    override func submit() {
        let params = ["content": taskForm.taskContentInput.text, "project_id": currentProject?.id, "user_id": currentUser?.id ]
        
        Alamofire.request(.PUT, "http://nuri.ekohe.com:4567/tasks/\(task!.id)", parameters: params, encoding: .JSON)
            .validate(statusCode: 200..<300)
            .response{  response in
                if self.deleteTaskOnLocal != nil && self.addTaskOnLocal != nil{
                    self.deleteTaskOnLocal!(self.project!.id, self.user!.id, self.task!)
                    self.addTaskOnLocal!(self.currentProject!.id, self.currentUser!.id, self.task!)
                }
                
                //                self.parent?.refresh()
        }
        taskForm.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
        
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
