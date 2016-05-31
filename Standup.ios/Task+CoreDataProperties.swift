//
//  Task+CoreDataProperties.swift
//  Standup.ios
//
//  Created by julien on 5/31/16.
//  Copyright © 2016 julien. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var id: String?
    @NSManaged var content: String?
    @NSManaged var day: NSDate?
    @NSManaged var teamId: String?
    @NSManaged var createdBy: User?
    @NSManaged var project: Project?

}
