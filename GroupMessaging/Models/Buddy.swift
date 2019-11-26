//
//  Buddy.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation

@objc class Buddy: NSObject {
    
    // MARK: - Properties
    @objc fileprivate(set) var fullname: String
    @objc fileprivate(set) var firebaseID: String
    
    // MARK: - Init
    init(firebaseID: String, fullname: String) {
        self.firebaseID = firebaseID
        self.fullname = fullname
    }
    
    init?(dict: [String: Any]) {
        guard let fullname = dict[FirebaseManager.DBKeys.fullname] as? String,
              let firebaseID = dict[FirebaseManager.DBKeys.firebaseID] as? String
                
              else {print("Failed to parse buddy with data: \(dict)"); return nil}
    
        self.firebaseID = firebaseID
        self.fullname = fullname
    }
    
    /// Sets the values to name, lat, long, and status so we don't have to create a whole new isntance of buddy
    func setIncomingChanging(dict: [String: Any]) {
        guard let name = dict[FirebaseManager.DBKeys.fullname] as? String,
            let firebaseID = dict[FirebaseManager.DBKeys.firebaseID] as? String else {
                print("Failed to parse buddy"); return
        }
        
        self.fullname = name
        self.firebaseID = firebaseID
        
    }
    
    /// Helps you find this specific instance of a buddy
    static func ==(lhs: Buddy, rhs: Buddy) -> Bool {
        return lhs.firebaseID == rhs.firebaseID
    }
}

extension Buddy {
    static let buddiesKey = "buddies"
}

// MARK: - Notificaiton observers
public extension NSNotification {
    @objc static let buddyLocationChange = Notification.Name("buddyLocationChange")
    @objc static let stopObservingBuddies = Notification.Name("stopObservingBuddies")
    @objc static let centerOnBuddyInMap = Notification.Name("centerOnBuddyInMap")
}


