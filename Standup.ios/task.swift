//
//  task.swift
//  Standup.ios
//
//  Created by julien on 2/21/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class Task{
    enum Status{
        case New
        case Done
    }
    var id: String
    var content: String
    var status: Status
    
    
    init?(id: String?, content c: String?, status s: String?){
        if id == nil || c == nil || s == nil {return nil}
        
        self.id = id!
        self.content = c!
        self.status = .New

        switch s!{
        case "new":
            self.status = Status.New
        case "done":
            self.status = Status.Done
        default:
            NSLog("Invalid task status")
        }
    }
    
    static func parseJSON(json: AnyObject?) -> Array<Task>{
        var parsedTasks = Array<Task>()
        let taskJSON = json as? Array<NSDictionary>
        if taskJSON != nil {
            for content in taskJSON!{
                let taskID = content.objectForKey("id") as? String
                let taskContent = content.objectForKey("content") as? String
                let taskStatus = content.objectForKey("status") as? String
                
                if let newTask = Task(id: taskID, content: taskContent, status: taskStatus){
                    parsedTasks.append(newTask)
                }
            }
        }
        
        return parsedTasks
    }
    
}
