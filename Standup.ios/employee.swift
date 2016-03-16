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
    var avatar:String?
    var tasks = [Task]()
    
    init(employee_name name: String, atatar_url avatar: String){
        self.name = name
        self.avatar = avatar
    }
    
    func appendTask(t: Task){
        self.tasks.append(t)
    }
    
    static func parseJSON(json: AnyObject?) -> Array<Employee>{
        var result = Array<Employee>()
        let employeesJSON = json as! Array<NSDictionary>
        
        for oneEmployee in employeesJSON{
            let employeeName = oneEmployee.objectForKey("employee_name") as! String
            let employeeAvatar = oneEmployee.objectForKey( "avatar" ) as! String
            let tasks = Task.parseJSON(oneEmployee.objectForKey("tasks"))
            let newEmployee = Employee(employee_name: employeeName, atatar_url: employeeAvatar)
            newEmployee.tasks += tasks
            result.append(newEmployee)
        }
        return result
    }
}