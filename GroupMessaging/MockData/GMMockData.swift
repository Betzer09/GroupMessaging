//
//  GMMockData.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation

class GMMockData {
    static let shared = GMMockData()
    
    // MARK: - SampleData
    
    static let testSender2 = GMUser(firebaseID: "SomeRandomID3", fullname: "Johnny")
    static let testSender3 = GMUser(firebaseID: "SomeRandomID4", fullname: "Martha Ward")
    static let testSender4 = GMUser(firebaseID: "SomeRandomID5", fullname: "Sophia Mes")
    static let testSender5 = GMUser(firebaseID: "SomeRandomID6", fullname: "Brooke Stalls")
    static let testSender6 = GMUser(firebaseID: "SomeRandomID7", fullname: "Kygo Now")
    static let testSender7 = GMUser(firebaseID: "SomeRandomID8", fullname: "Happy Tree")
    static let testSender8 = GMUser(firebaseID: "SomeRandomID9", fullname: "Rick Betzer")
    static let testSender9 = GMUser(firebaseID: "SomeRandomID10", fullname: "Chris Hess")
    
    // iPhone 8 Test
//    static let currentSender = GMUser(firebaseID: "SomeRandomID2", fullname: "Alex Ward")
//    static let testSender1 = GMUser(firebaseID: "SomeRandomID1", fullname: "Austin Betzer")
    
    // iPhone 10 Test
    static let testSender1 = GMUser(firebaseID: "SomeRandomID2", fullname: "Alex Ward")
    static let currentSender = GMUser(firebaseID: "SomeRandomID1", fullname: "Austin Betzer")
    
    private let usersData = [
    testSender1,
    testSender2,
    testSender3,
    testSender4,
    testSender5,
    testSender6,
    testSender7,
    testSender8,
    testSender9,
    currentSender
    ]
    
    func matchSender(_ senderID: String) -> GMUser {
        return usersData.first(where: { $0.senderId == senderID })!
    }
    
}
