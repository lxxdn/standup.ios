//
//  AddTaskViewController.swift
//  Standup.ios
//
//  Created by julien on 4/10/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
