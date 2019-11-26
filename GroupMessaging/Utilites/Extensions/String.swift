//
//  String.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation

extension String {
    /// converts a string to date
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.date(from: self)!
    }
    
       func getInitals() -> String {
        let splitStr = self.split(separator: " ")
        
        var initals = ""
        
        for str in splitStr {
            guard let char = str.first else {continue}
            initals.append(char)
            continue
        }
        
        return removeSpecialCharsFromString(text: initals)
    }
    
    private func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return String(text.filter {okayChars.contains($0) })
    }
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self)
    }
}
