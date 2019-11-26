//
//  Message.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import MessageKit
import CoreLocation

/**
 A message that is being sent to a user
 */
struct Message: MessageType {
    
    struct DBKeys {
        static let textKey = "text"
        static let senderNameKey = "sender_name"
        static let senderIDKey = "sender_id"
        static let conversationIDKey = "conversation_id"
        static let sendDateKey = "sent_date"
        static let seenByKey = "seen_by"
        static let messageID = "message_id"
        static let messageType = "message_type"
    }
    
    /// The ID of the conversation that the message belongs too.
    let conversationID: String
    
    // MARK: - Message Type Protocal
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    var text: String?
    
    private init(kind: MessageKind, user: GMUser, text: String? = nil) {
        self.kind = kind
        self.sender = user
        self.messageId = UUID().uuidString
        self.sentDate = Date()
        self.conversationID = UUID().uuidString
    }
    
    // MARK: - Custom Inits
    init(location: CLLocation, user: GMUser) {
        let locationItem = CoordinateItem(location: location)
        self.init(kind: .location(locationItem), user: user)
    }
    
    init(text: String, user: GMUser) {
        self.init(kind: .text(text), user: user, text: text)
    }
    
    
    // MARK: - Failable Init
    
    init?(dict: [String: Any]) {
        guard let senderName = dict[DBKeys.senderNameKey] as? String,
            let senderID = dict[DBKeys.senderNameKey] as? String,
            let conversationID = dict[DBKeys.senderNameKey] as? String,
            let sentDate = dict[DBKeys.senderNameKey] as? String,
            let messageId = dict[DBKeys.messageID] as? String,
            let text = dict[DBKeys.textKey] as? String
            else {return nil}
        
        self.sender = GMUser(firebaseID: senderID, fullname: senderName)
        self.conversationID = conversationID
        self.sentDate = sentDate.toDate()
        self.messageId = messageId
        self.kind = .text(text)
    }
    
    var jsonDict: [String: Any] {
        [
            DBKeys.senderNameKey: self.sender.displayName,
            DBKeys.senderIDKey: self.sender.senderId,
            DBKeys.textKey: self.text as Any,
            DBKeys.conversationIDKey: self.conversationID,
            DBKeys.sendDateKey: self.sentDate.toString(),
            DBKeys.messageType: "\(self.kind)"
        ]
    }
}

// MARK: - Custom Messaging Types
private struct CoordinateItem: LocationItem {

    var location: CLLocation
    var size: CGSize

    init(location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }

}
