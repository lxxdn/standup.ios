//
//  DataLayer+FetchDataFunctions.swift
//  Standup.ios
//
//  Created by julien on 6/4/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation
import CoreData

extension DataLayer{
    func fetchTasks(viewController: UIViewController, callbackFn: (UIViewController, [Task]) -> Void){
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
                callbackFn(viewController, tasks)
            }
        }
    }
}