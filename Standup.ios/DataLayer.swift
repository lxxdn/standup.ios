//
//  DataLayer.swift
//  Standup.ios
//
//  Created by julien on 5/31/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation
import Meteor

class DataLayer{
    private init(){}
    private static var instance: DataLayer? = nil
    static func getInstance() -> DataLayer {
        if instance == nil {
            instance = DataLayer()
        }
        return instance!
    }
    let Meteor = METCoreDataDDPClient(serverURL: NSURL(string: "http://localhost:3000/websocket")!)
    func initDataLayer(){   
        Meteor.connect()
    }
    
    func addSubscription(name: String, parameters: Dictionary<String, AnyObject>) -> METSubscription{
        return Meteor.addSubscriptionWithName(name, parameters: [parameters])
    }
    
    func fetchObjects(request: NSFetchRequest) -> [AnyObject]? {
        var objects: [AnyObject]? = nil
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Meteor.mainQueueManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
            objects = fetchedResultController.fetchedObjects
            let task = objects![0] as! Task
            print(task.content)
        }catch let error as NSError{
            print(error)
            // do nothing
        }
        return objects
    }
}