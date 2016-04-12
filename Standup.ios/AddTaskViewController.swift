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
        let params = ["content": taskForm.taskContentInput.text, "project_id": currentProject?.id, "team_id": currentUser?.team_id, "user_id": currentUser?.id ]

        Alamofire.request(.POST, "http://nuri.ekohe.com:4567/task/create", parameters: params, encoding: .JSON)
            .validate(statusCode: 200..<300)
            .response{  response in
                print(response)
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
