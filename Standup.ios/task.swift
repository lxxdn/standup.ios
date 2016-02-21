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
    var content: String?
    var status: Status?
    
    init(content c: String, status s: String){
        self.content = c
        switch s{
        case "new":
            self.status = Status.New
        case "done":
            self.status = Status.Done
        default:
            NSLog("Invalid task status")
        }
    }
    
}
