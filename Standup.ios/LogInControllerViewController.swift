//
//  LogInControllerViewController.swift
//  Standup.ios
//
//  Created by julien on 3/31/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import Alamofire

class LogInControllerViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwdInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        Alamofire.request(.GET, "http://nuri.ekohe.com:4567/allUsers")
            .responseJSON{ response in
                switch response.result {
                case .Success(let json):
                    let usersJSON = json as! NSDictionary
                    let data = usersJSON.objectForKey("users") as! Array<NSDictionary>
                    ArchivedKeyCache.save(data, filename: "user_list")
                case .Failure(let error):
                    NSLog("Failed to get users josn becase \(error)")
                }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func login() {
        let email = emailInput.text
        let passwd = passwdInput.text

        if Login().login(email, passwd: passwd){
            self.navigationController?.popViewControllerAnimated(true)
        }
        
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
