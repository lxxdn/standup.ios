//
//  AppDelegate.swift
//  Standup.ios
//
//  Created by julien on 2/15/16.
//  Copyright © 2016 julien. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let navigationController = UINavigationController(rootViewController: AllTasksViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        Meteor.connect()
//        let subscription = Meteor.addSubscriptionWithName("allUserData", parameters: [["_id": "pmEn8uixQEtccsztz"]])
//        
//        subscription.whenDone {(error) -> Void in
//            if let error = error{
//                print(error)
//            }
//            let request = NSFetchRequest(entityName: "User")
//            request.sortDescriptors = [NSSortDescriptor(key: "avatar", ascending: true)]
//            do{
//                let users = try Meteor.mainQueueManagedObjectContext.executeFetchRequest(request)
//                let firstUser = users[0] as! User
//                print(firstUser)
//            }catch{
//                // do nothing
//            }
//         }
//        ********************************************************************************************************************
//        let subscriptionLoader = SubscriptionLoader()
//        subscriptionLoader.addSubscriptionWithName("allUserData", parameters: [["_id": "pmEn8uixQEtccsztz"]])
//        
//        subscriptionLoader.whenReady({
//            let request = NSFetchRequest(entityName: "User")
//            request.sortDescriptors = [NSSortDescriptor(key: "avatar", ascending: true)]
//            let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Meteor.mainQueueManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//            do {
//                try fetchedResultController.performFetch()
//                let users = fetchedResultController.fetchedObjects
//                print(fetchedResultController.sections?.count)
//                
//                print(users!.count)
//            }catch{
//                // do nothing
//            }
//        })
        
        
        let subscription = Meteor.addSubscriptionWithName("allUserData", parameters: [["_id": "pmEn8uixQEtccsztz"]])
        
        subscription.whenDone {(error) -> Void in
            if let error = error{
                print(error)
            }
            let request = NSFetchRequest(entityName: "User")
            request.sortDescriptors = [NSSortDescriptor(key: "avatar", ascending: true)]
            let fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Meteor.mainQueueManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            do {
                try fetchedResultController.performFetch()
                let users = fetchedResultController.fetchedObjects
                let firstUser = users?[0] as! User
                let profile = firstUser.profile as! Dictionary<String, String>
                print(fetchedResultController.sections?.count)

                print(users!.count)
            }catch{
                // do nothing
            }
            
         }

        
        ArchivedKeyCache.prepareForDefaultValue()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

