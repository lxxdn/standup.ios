//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var id: String?
    @NSManaged var profile: String?
    @NSManaged var avatar: String?
    @NSManaged var teamId: String?

}
