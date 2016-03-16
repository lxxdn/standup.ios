//
//  Project.swift
//  Standup.ios
//
//  Created by julien on 2/21/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class Project {
    var id:String?
    var name:String?
    var employees = [Employee]()
    
    init(project_id id: String, project_name name: String){
        self.name = name
        self.id = id
    }
    
    static func parseJSON(json: AnyObject?) -> Array<Project>{
        let content = json as! Array<NSDictionary>
        var result = Array<Project>()
        for projectContent in content{
            let projectID = projectContent.objectForKey("project_id") as! String
            let projectName = projectContent.objectForKey("project_name") as! String
            let employees = Employee.parseJSON(projectContent.objectForKey("employeesOnProject"))
            let newProject = Project(project_id: projectID, project_name: projectName)
            newProject.employees +=  employees
            result.append(newProject)
        }
        return result
    }
}