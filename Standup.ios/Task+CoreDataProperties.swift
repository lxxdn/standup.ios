//
//  Task+CoreDataProperties.swift
//  Standup.ios
//
//  Created by julien on 6/6/16.
//  Copyright © 2016 julien. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var content: String?
    @NSManaged var createdAt: String?
    @NSManaged var day: String?
    @NSManaged var teamId: String?
    @NSManaged var project: NSObject?
    @NSManaged var createdBy: NSObject?

}
