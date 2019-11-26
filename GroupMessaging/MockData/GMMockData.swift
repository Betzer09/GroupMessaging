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
    let currentSender = GMUser(firebaseID: "SomeRandomID1", fullname: "Austin Betzer")
    
}
