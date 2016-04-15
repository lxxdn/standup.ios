//
//  AddTaskViewController.swift
//  Standup.ios
//
//  Created by julien on 4/10/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class AddTaskViewController: TaskFormViewController {
    
    var addTaskOnLocal : ((String, String, Task) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func cancel(btn: UIButton){
        print("subclass")
        super.cancel(btn)
    }
    override func submit() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.stringFromDate(NSDate())
        let params = ["content": taskForm.taskContentInput.text, "project_id": currentProject?.id, "team_id": currentUser?.team_id, "user_id": currentUser?.id, "date": date]

        Alamofire.request(.POST, "http://nuri.ekohe.com:4567/task/create", parameters: params, encoding: .JSON)
            .validate(statusCode: 200..<300)
            .responseJSON{  response in
                switch response.result{
                case .Success(let task):
                    if let taskJSON = task as? Dictionary<String, String>{
                        let newTask = Task(id: taskJSON["_id"], content: taskJSON["content"], status: "new")
                        if self.addTaskOnLocal != nil{
                            self.addTaskOnLocal!(self.currentProject!.id, self.currentUser!.id, newTask!)
                        }
                        if self.refreshFn != nil{
                            self.refreshFn!()
                        }
                    }
                case .Failure(let error):
                    NSLog("Failed to create a task because \(error)" )
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
