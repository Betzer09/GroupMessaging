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
    
    let testSender1 = GMUser(firebaseID: "SomeRandomID2", fullname: "Alex Ward")
    let testSender2 = GMUser(firebaseID: "SomeRandomID3", fullname: "Johnny")
    let testSender3 = GMUser(firebaseID: "SomeRandomID4", fullname: "Martha Ward")
    let testSender4 = GMUser(firebaseID: "SomeRandomID5", fullname: "Sophia Mes")
    let testSender5 = GMUser(firebaseID: "SomeRandomID6", fullname: "Brooke Stalls")
    let testSender6 = GMUser(firebaseID: "SomeRandomID7", fullname: "Kygo Now")
    let testSender7 = GMUser(firebaseID: "SomeRandomID8", fullname: "Happy Tree")
    let testSender8 = GMUser(firebaseID: "SomeRandomID9", fullname: "Rick Betzer")
    let testSender9 = GMUser(firebaseID: "SomeRandomID10", fullname: "Chris Hess")
    
    let currentSender = GMUser(firebaseID: "SomeRandomID1", fullname: "Austin Betzer")
}
