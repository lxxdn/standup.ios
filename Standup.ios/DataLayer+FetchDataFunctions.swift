//
//  DataLayer+FetchDataFunctions.swift
//  Standup.ios
//
//  Created by julien on 6/4/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation
import CoreData


struct ParsedProject{
    let project_id: String
    let project_name: String
    var tasks: [Task]
}

extension DataLayer{
    func fetchTasks(viewController: UIViewController, callbackFn: (UIViewController, [ParsedProject]) -> Void){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.stringFromDate(NSDate())
        
        let subscription = addSubscription("tasks", parameters: ["team": ["_id":"pmEn8uixQEtccsztz"], "day": date ])
        subscription.whenDone {[unowned self] error -> Void in
            if let error = error{
                print(error)
            }
            let request = NSFetchRequest(entityName: "Task")
            request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            let tasks = self.fetchObjects(request) as? [Task]
            if let tasks = tasks{
                let parsedData = self.parseTasksData(tasks)
                callbackFn(viewController, parsedData)
            }
        }
    }
    
    func parseTasksData(tasks: [Task]) -> [ParsedProject]{
        var result:[ParsedProject] = []
        for task in tasks{
            let currentProject = task.project as! Dictionary<String, String>
            var projectExists = false
            
            for index in 0..<result.count{
                let existedProject = result[index]
                if existedProject.project_name == currentProject["name"]{
                    projectExists = true
                    result[index].tasks.append(task)
                }
            }
            if !projectExists{
                let newProject = ParsedProject(project_id: currentProject["id"]!, project_name: currentProject["name"]!, tasks: [task])
                result.append(newProject)
            }
        }
        return result
    }
}