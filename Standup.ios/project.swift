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
    
    func appendEmployee(e: Employee){
        self.employees.append(e)
    }
}