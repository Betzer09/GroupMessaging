//
//  Message.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation

/**
 A message that is being sent to a user
 */
struct Message {
    
    struct DBKeys {
        static let textKey = "text"
        static let senderNameKey = "sender_name"
        static let senderIDKey = "sender_id"
        static let conversationIDKey = "conversation_id"
        static let sendByKey = "seen_by"
    }
    
    /// The message that was sent
    let text: String
    /// The name of the user who sent the message
    let senderName: String
    /// The ID of the user who sent the message
    let senderID: String
    /// The ID of the conversation that the message belongs too.
    let conversationID: String
    /// A dictionary that tracks who has seen what message with the key being the users id and the value being the users name
    var seenBy: [String: String] = [:]
    
    
    init?(dict: [String: Any]) {
        guard let text = dict[Message.DBKeys.textKey] as? String,
            let senderName = dict[Message.DBKeys.senderNameKey] as? String,
            let senderID = dict[Message.DBKeys.senderIDKey] as? String,
            let conversationID = dict[Message.DBKeys.conversationIDKey] as? String,
            let seenBy = dict[Message.DBKeys.sendByKey] as? [String: String] else {return nil}
        
        self.text = text
        self.senderName = senderName
        self.senderID = senderID
        self.conversationID = conversationID
        self.seenBy = seenBy
    }
    
    /// The json representation of a message
    var jsonDict: [String: Any] {
        return [
            Message.DBKeys.textKey: text,
            Message.DBKeys.senderNameKey: senderName,
            Message.DBKeys.senderIDKey: senderID,
            Message.DBKeys.conversationIDKey: conversationID,
            Message.DBKeys.sendByKey: seenBy
        ]
    }

}
