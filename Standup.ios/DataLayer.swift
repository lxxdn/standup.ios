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
    static let Meteor = METCoreDataDDPClient(serverURL: NSURL(string: "http://localhost:3000/websocket")!)
    
    class func initDataLayer() {
        Meteor.connect()
    }
}