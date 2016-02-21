//
//  user.swift
//  Standup.ios
//
//  Created by julien on 2/21/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class Employee {
    var name: String?
    var avatar:NSURL?
    var tasks = [Task]()
    
    init(employee_name name: String, atatar_url avatar: NSURL){
        self.name = name
        self.avatar = avatar
    }
    
    func appendTask(t: Task){
        self.tasks.append(t)
    }
}