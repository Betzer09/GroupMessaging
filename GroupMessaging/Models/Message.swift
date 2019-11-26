//
//  Message.swift
//  GroupMessaging
//
//  Created by Austin Betzer on 11/26/19.
//  Copyright © 2019 Strides. All rights reserved.
//

import Foundation
import MessageKit

/**
 A message that is being sent to a user
 */
struct Message: MessageType {
    struct DBKeys {
        static let textKey = "text"
        static let senderNameKey = "sender_name"
        static let senderIDKey = "sender_id"
        static let conversationIDKey = "conversation_id"
        static let sendByKey = "seen_by"
    }
    
    /// The ID of the conversation that the message belongs too.
    let conversationID: String
    
    // MARK: - Message Type Protocal
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    init(kind: MessageKind, sender: GMUser, sendDate: Date = Date(), messageId: String = UUID().uuidString, conversationID: String) {
        self.sender = sender
        self.kind = kind
        self.conversationID = conversationID
        self.sentDate = sendDate
        self.messageId = messageId
    }
    
    init?(dict: [String: Any]) {
        return nil
    }
}
