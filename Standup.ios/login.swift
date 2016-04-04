//
//  login.swift
//  Standup.ios
//
//  Created by julien on 4/2/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation
import Alamofire

class Login {
    
    var userList = ArchivedKeyCache.load(ArchivedKeyCache.StaticKeyName.user_list) as? [Dictionary<String, String>]
    
    func login(email: String?, passwd: String?) -> Bool {
        if email == "" || passwd == ""{
            return false
        }
        let emailList = userList?.map{ user in user["email"]! }
        if let list = emailList {
            if list.indexOf(email!) != nil {
                // can be replaced by read api
                if passwd == "ekohe2000*"{
                    // save to the cache
                    let currentUser = userList?.filter{ user in user["email"] == email }.first
                    if currentUser != nil{
                        let userDefault = NSUserDefaults.standardUserDefaults()
                        userDefault.setObject(currentUser, forKey: "current_user")
                    }
                    return true
                }
            }
        }
        return false
    }
    
    static func isLoggedIn() -> Bool{
        let userDefault = NSUserDefaults.standardUserDefaults()
        //userDefault.removeObjectForKey("current_user")
        let currentUser = userDefault.dictionaryForKey("current_user")
        if currentUser != nil {
            return true
        }
        return false
    }
}
