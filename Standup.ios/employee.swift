//
//  user.swift
//  Standup.ios
//
//  Created by julien on 2/21/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class Employee {
    var id: String
    var name: String
    var avatar:String
    var team_id: String
    var tasks = [Task]()
    
    init?(id: String? , employee_name name: String?, atatar_url avatar: String?, team_id: String?){
        if id == nil || name == nil || avatar == nil || team_id == nil{ return nil}
        
        self.id = id!
        self.name = name!
        self.avatar = avatar!
        self.team_id = team_id!
    }
    
    convenience init?(data: Dictionary<String, String>){
        let id = data["employee_id"]
        let name = data["employee_name"]
        let avatar = data["avatar"]
        let team_id = data["team_id"]
        self.init(id: id!, employee_name: name!, atatar_url: avatar!, team_id: team_id!)
    }
    
    static func parseJSON(json: AnyObject?) -> Array<Employee>{
        var result = Array<Employee>()
        let employeesJSON = json as! Array<NSDictionary>
        
        for oneEmployee in employeesJSON{
            let employeeID = oneEmployee.objectForKey("employee_id") as? String
            let employeeName = oneEmployee.objectForKey("employee_name") as? String
            let employeeAvatar = oneEmployee.objectForKey( "avatar" ) as? String
            let teamID = oneEmployee.objectForKey("team_id") as? String
            if let employee = Employee(id: employeeID, employee_name: employeeName, atatar_url: employeeAvatar, team_id: teamID){
                if let tasksJSON = oneEmployee.objectForKey("tasks"){
                    let tasks = Task.parseJSON(tasksJSON)
                    employee.tasks += tasks
                }
                result.append(employee)
            }
        }
        return result
    }
}