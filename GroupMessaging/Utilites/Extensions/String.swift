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
//        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: self)
    }
    
    func toPrettyString() -> String {
        
        // Calulate time between now and the time it was sent
        let timerInterval = Date().timeIntervalSince(self)
        
        // Check to see if time interval is less then an hour
        if timerInterval < 60 * 60 {
            
            let minutes = Int(timerInterval / 60)

            let pluralText = minutes == 1 ? "min" : "mins"
            return "\(minutes) \(pluralText) ago"
        } else {
            let dateFormatter = DateFormatter()
            // Format date
            dateFormatter.dateFormat = "MMM d, h:mm a" // ex Nov, 27, 5:10 pm
            return dateFormatter.string(from: self)
        }
    }
}
