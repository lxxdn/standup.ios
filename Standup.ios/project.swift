//
//  Project.swift
//  Standup.ios
//
//  Created by julien on 2/21/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class Project {
    var id:String
    var name:String
    var employees = [Employee]()
    
    init?(project_id id: String?, project_name name: String?){
        if id == nil || name == nil{return nil}
        self.name = name!
        self.id = id!
    }
    convenience init?(data: Dictionary<String, String>){
        let id = data["project_id"]
        let name = data["project_name"]
        self.init(project_id: id!, project_name: name!)
    }
    
    static func parseJSON(json: AnyObject?) -> Array<Project>{
        let content = json as! Array<NSDictionary>
        var result = Array<Project>()
        for projectContent in content{
            let projectID = projectContent.objectForKey("project_id") as! String
            let projectName = projectContent.objectForKey("project_name") as! String
            if let project = Project(project_id: projectID, project_name: projectName){
                if let employeeJSON = projectContent.objectForKey("employeesOnProject"){
                    let employees = Employee.parseJSON(employeeJSON)
                    project.employees +=  employees
                }
                result.append(project)
            }
        }
        return result
    }
}