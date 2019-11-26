//
//  Buddy.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import MessageKit

@objc
class GMUser: NSObject, SenderType {
    
    // MARK: - Properties
    @objc fileprivate(set) var fullname: String
    @objc fileprivate(set) var firebaseID: String
    
    // Sender Type Protocal
    var senderId: String
    var displayName: String
    var initals: String {
        get {
            displayName.getInitals()
        }
    }
    
    var jsonDict: [String: Any] {
        return [
            FirebaseManager.DBKeys.fullname: self.fullname,
            FirebaseManager.DBKeys.firebaseID: self.firebaseID
        ]
    }
    
    // MARK: - Init
    init(firebaseID: String, fullname: String) {
        self.firebaseID = firebaseID
        self.fullname = fullname
        self.senderId = firebaseID
        self.displayName = fullname
    }
    
    init?(dict: [String: Any]) {
        guard let fullname = dict[FirebaseManager.DBKeys.fullname] as? String,
              let firebaseID = dict[FirebaseManager.DBKeys.firebaseID] as? String
              else {print("Failed to parse buddy with data: \(dict)"); return nil}
    
        self.firebaseID = firebaseID
        self.fullname = fullname
        self.senderId = firebaseID
        self.displayName = fullname
    }
    
    /// Sets the values to name, lat, long, and status so we don't have to create a whole new isntance of buddy
    func setIncomingChanges(dict: [String: Any]) {
        guard let name = dict[FirebaseManager.DBKeys.fullname] as? String,
            let firebaseID = dict[FirebaseManager.DBKeys.firebaseID] as? String else {
                print("Failed to parse buddy"); return
        }
        
        self.fullname = name
        self.firebaseID = firebaseID
        self.senderId = firebaseID
        self.displayName = fullname
    }
    
    /// Helps you find this specific instance of a buddy
    static func ==(lhs: GMUser, rhs: GMUser) -> Bool {
        return lhs.firebaseID == rhs.firebaseID
    }
}



