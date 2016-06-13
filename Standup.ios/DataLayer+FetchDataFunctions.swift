//
//  DataLayer+FetchDataFunctions.swift
//  Standup.ios
//
//  Created by julien on 6/4/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation
import CoreData


class ParsedProject{
    init(project_id: String, project_name: String, tasks: [Task]){
        self.project_id = project_id
        self.project_name = project_name
        self.tasks = tasks
    }
    let project_id: String
    let project_name: String
    var tasks: [Task]
}

class ParsedUser{
    init(user_id: String, user_name: String, avatar: String, tasks: [Task]){
        self.user_id = user_id
        self.user_name = user_name
        self.avatar = avatar
        self.tasks = tasks
    }
    let user_id: String
    let user_name: String
    let avatar: String
    var tasks: [Task]
}

class ParsedTask{
    init(project_id: String, project_name: String, users: [ParsedUser]){
        self.project_id = project_id
        self.project_name = project_name
        self.users = users
    }
    let project_id: String
    let project_name: String
    var users: [ParsedUser]
}

extension DataLayer{
    func fetchTasks(callbackFn: ([ParsedTask]) -> Void){
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
                callbackFn(parsedData)
            }
        }
    }
    
    func parseTasksData(tasks: [Task]) -> [ParsedTask]{
        var result: [ParsedTask] = []
        let projects = _parseTasksData(tasks)
        for project in projects{
            let users = _groupTasksByUser(project.tasks)
            result.append(ParsedTask.init(project_id: project.project_id, project_name: project.project_name, users: users))
        }
        return result
    }
    
    func _parseTasksData(tasks: [Task]) -> [ParsedProject]{
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
    func _groupTasksByUser(tasks: [Task]) -> [ParsedUser]{
        var result: [ParsedUser] = []
        for task in tasks{
            let currentUser = task.createdBy as! Dictionary<String, String>
            var userExists = false
            for index in 0..<result.count{
                let existedUser = result[index]
                if existedUser.user_id == currentUser["id"]{
                    userExists = true
                    result[index].tasks.append(task)
                }
            }
            if !userExists{
                let newUser = ParsedUser(user_id: currentUser["id"]!, user_name: currentUser["name"]!, avatar: currentUser["picture"]!, tasks: [task])
                result.append(newUser)
            }
        }
        return result
    }
}